#! /usr/bin/env bash
# Verifies the declared hash of every package (per system) and icon in apps.nix.
#
# Usage:
#   tests/check-hashes.sh                 # check everything
#   tests/check-hashes.sh photocraft ...  # only these apps
#   FIX=1 tests/check-hashes.sh           # also print the correct hash for bad/missing entries
#   WRITE=1 tests/check-hashes.sh         # write correct hashes into apps.nix (implies FIX=1)
#
# Exit code: 0 if all hashes matched, 1 otherwise (also after WRITE=1, so re-run to confirm).
set -uo pipefail

cd "$(dirname "$0")/.."

NIX=(nix --extra-experimental-features "nix-command flakes")
FILTER=("$@")
[ -n "${WRITE:-}" ] && FIX=1

if ! command -v jq >/dev/null || ! command -v perl >/dev/null; then
  echo "jq and perl are required (nix shell nixpkgs#jq nixpkgs#perl)" >&2
  exit 2
fi

list="$("${NIX[@]}" eval --json --file tests/list-sources.nix)" || {
  echo "failed to evaluate tests/list-sources.nix" >&2
  exit 2
}

ok=0
fail=0
declare -a failures=()

want() {
  [ ${#FILTER[@]} -eq 0 ] && return 0
  local n
  for n in "${FILTER[@]}"; do [ "$n" = "$1" ] && return 0; done
  return 1
}

quote() { perl -e 'print quotemeta shift' "$1"; }

# Replace `old` with `new` inside one app's block of apps.nix.
# `old` is a regex with two groups: (prefix)(thing replaced); prefix is kept.
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

apply_fix() {
  [ -n "${WRITE:-}" ] || return 0
  local name=$1 kind=$2 system=$3 declared=$4 got=$5

  if [ -n "$declared" ]; then
    # Existing (wrong or malformed) hash: swap the literal string.
    patch_block "$name" "()($(quote "$declared"))" "$got" && { echo "          written to apps.nix"; return 0; }
  elif [ "$kind" = icon ]; then
    patch_block "$name" '(\biconHash\s*=\s*)(null)' "\"$got\"" && { echo "          written to apps.nix"; return 0; }
  else
    # `hash = null` under sources.<system>, or top-level for x86_64-linux apps without sources.
    patch_block "$name" "(\\b$(quote "$system")\\.hash\\s*=\\s*)(null)" "\"$got\"" && { echo "          written to apps.nix"; return 0; }
    if [ "$system" = x86_64-linux ]; then
      patch_block "$name" '((?<![A-Za-z.])hash\s*=\s*)(null)' "\"$got\"" && { echo "          written to apps.nix"; return 0; }
    fi
  fi
  echo "          could not patch apps.nix automatically, edit it by hand"
}

while IFS= read -r row; do
  name=$(jq -r .name <<<"$row")
  want "$name" || continue

  kind=$(jq -r .kind <<<"$row")
  system=$(jq -r .system <<<"$row")
  url=$(jq -r .url <<<"$row")
  declared=$(jq -r '.hash // ""' <<<"$row")
  label=$(printf '%-15s %-8s %-15s' "$name" "$kind" "$system")

  # Download and hash (also fails on 404s).
  if ! got=$("${NIX[@]}" store prefetch-file --json --hash-type sha256 "$url" 2>/tmp/check-hashes.err | jq -r .hash) \
    || [ -z "$got" ] || [ "$got" = null ]; then
    echo "FAIL    $label download failed: $url"
    sed 's/^/          /' /tmp/check-hashes.err | tail -n 2
    fail=$((fail + 1))
    failures+=("$label download failed")
    continue
  fi

  if [ -z "$declared" ]; then
    echo "MISSING $label hash is null, real hash: $got"
    fail=$((fail + 1))
    failures+=("$label missing")
    [ -n "${FIX:-}" ] && echo "          -> $got"
    apply_fix "$name" "$kind" "$system" "" "$got"
    continue
  fi

  # Normalise to SRI so base32 / hex / unpadded variants compare correctly.
  if ! norm=$("${NIX[@]}" hash convert --hash-algo sha256 --to sri "$declared" 2>/dev/null); then
    echo "INVALID $label malformed hash '$declared' (real: $got)"
    fail=$((fail + 1))
    failures+=("$label malformed")
    [ -n "${FIX:-}" ] && echo "          -> $got"
    apply_fix "$name" "$kind" "$system" "$declared" "$got"
    continue
  fi

  if [ "$norm" = "$got" ]; then
    if [ "$declared" != "$got" ]; then
      echo "OK      $label (valid, but not written in SRI form: $got)"
    else
      echo "OK      $label"
    fi
    ok=$((ok + 1))
  else
    echo "MISMATCH $label"
    echo "          declared: $declared"
    echo "          actual:   $got"
    fail=$((fail + 1))
    failures+=("$label mismatch")
    [ -n "${FIX:-}" ] && echo "          -> $got"
    apply_fix "$name" "$kind" "$system" "$declared" "$got"
  fi
done < <(jq -c '.[]' <<<"$list")

echo
echo "passed: $ok  failed: $fail"
if [ "$fail" -gt 0 ]; then
  printf '  - %s\n' "${failures[@]}"
  exit 1
fi
