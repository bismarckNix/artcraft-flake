#! /usr/bin/env bash
# Compares the version of every app in apps.nix with the latest GitHub release.
#
# Usage:
#   tests/check-versions.sh                 # check everything
#   tests/check-versions.sh photocraft ...  # only these apps
#   WRITE=1 tests/check-versions.sh         # bump outdated versions in apps.nix, then
#                                           # fix the hashes of the bumped apps
#   WRITE=1 SKIP_HASHES=1 tests/check-versions.sh   # bump versions only
#
# Exit code: 1 if any app is outdated or could not be checked, otherwise 0.
set -uo pipefail

cd "$(dirname "$0")/.."

NIX=(nix --extra-experimental-features "nix-command flakes")
FILTER=("$@")

for cmd in jq perl curl; do
  command -v "$cmd" >/dev/null || { echo "$cmd is required" >&2; exit 2; }
done

apps=$("${NIX[@]}" eval --json --file apps.nix \
  --apply 'a: builtins.mapAttrs (_: v: {
    version = v.version;
    tag = v.tag or null;
    owner = v.owner or "storytold";
  }) a') || {
  echo "Failed to evaluate apps.nix" >&2
  exit 1
}

want() {
  [ ${#FILTER[@]} -eq 0 ] && return 0
  local n
  for n in "${FILTER[@]}"; do [ "$n" = "$1" ] && return 0; done
  return 1
}

# Latest release tag of <owner>/<name>, via the /releases/latest redirect.
latest_tag() {
  local owner=$1 name=$2 loc
  loc=$(curl -sS -o /dev/null --max-time 20 -w '%{redirect_url}' \
    "https://github.com/$owner/$name/releases/latest") || return 1
  case $loc in
    */releases/tag/*) printf '%s\n' "${loc##*/releases/tag/}" ;;
    *) return 1 ;;
  esac
}

# Replace group 2 of `old` with `new` inside one app's block of apps.nix.
# Returns 0 if the file changed.
patch_block() {
  local before after
  before=$(cksum <apps.nix)
  NAME=$1 OLD=$2 NEW=$3 perl -0pi -e '
    s{(^  \Q$ENV{NAME}\E = .*?)(?=^  [A-Za-z0-9_-]+ = |\z)}
     { my $b = $1; $b =~ s/$ENV{OLD}/$1$ENV{NEW}/; $b }mseg
  ' apps.nix
  after=$(cksum <apps.nix)
  [ "$before" != "$after" ]
}

ok=0
bad=0
declare -a updated=() problems=()

for name in $(jq -r 'keys[]' <<<"$apps"); do
  want "$name" || continue

  owner=$(jq -r ".\"$name\".owner" <<<"$apps")
  current=$(jq -r ".\"$name\".version" <<<"$apps")
  customtag=$(jq -r ".\"$name\".tag // empty" <<<"$apps")
  label=$(printf '%-15s' "$name")

  if ! tag=$(latest_tag "$owner" "$name") || [ -z "$tag" ]; then
    echo "FAIL     $label no release found (or request failed)"
    bad=$((bad + 1))
    problems+=("$name: no release found")
    continue
  fi
  latest=${tag#v}

  if [ "$current" = "$latest" ]; then
    echo "OK       $label $current"
    ok=$((ok + 1))
    continue
  fi

  newest=$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -n 1)
  if [ "$newest" != "$latest" ]; then
    echo "AHEAD    $label apps.nix has $current, latest release is $latest"
    ok=$((ok + 1))
    continue
  fi

  echo "OUTDATED $label $current -> $latest"
  bad=$((bad + 1))
  problems+=("$name: $current -> $latest")

  [ -n "${WRITE:-}" ] || continue
  if [ -n "$customtag" ]; then
    echo "           has a custom tag ($customtag), edit apps.nix by hand"
  elif patch_block "$name" '(\bversion\s*=\s*)("[^"]*")' "\"$latest\""; then
    echo "           written to apps.nix"
    updated+=("$name")
  else
    echo "           could not patch apps.nix automatically, edit it by hand"
  fi
done

echo
echo "up to date: $ok  needs attention: $bad"
[ "${#problems[@]}" -gt 0 ] && printf '  - %s\n' "${problems[@]}"

# A new version means new hashes: let check-hashes.sh fill them in.
if [ "${#updated[@]}" -gt 0 ]; then
  if [ -n "${SKIP_HASHES:-}" ]; then
    echo
    echo "Hashes are now stale. Run: WRITE=1 tests/check-hashes.sh ${updated[*]}"
  else
    echo
    echo "Updating hashes for: ${updated[*]}"
    WRITE=1 "$(dirname "$0")/check-hashes.sh" "${updated[@]}"
  fi
fi

[ "$bad" -gt 0 ] && exit 1
exit 0
