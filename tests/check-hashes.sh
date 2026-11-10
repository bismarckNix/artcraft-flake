#!/usr/bin/env bash
# Verify package and icon hashes declared in apps.nix.
#
# Usage:
#   tests/check-hashes.sh                 # Check everything
#   tests/check-hashes.sh photocraft      # Check selected apps
#   FIX=1 tests/check-hashes.sh           # Print corrected hashes
#   WRITE=1 tests/check-hashes.sh         # Update apps.nix (still exits 1 if it found mismatches)

set -uo pipefail
cd "$(dirname "$0")/.."

NIX=(nix --extra-experimental-features "nix-command flakes")
FILTER=("$@")
[ -n "${WRITE:-}" ] && FIX=1

for cmd in nix jq perl; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "Missing dependency: $cmd" >&2
    exit 2
  }
done

list=$("${NIX[@]}" eval --json --file tests/list-sources.nix) || {
  echo "Failed to evaluate tests/list-sources.nix" >&2
  exit 2
}

ok=0
fail=0
declare -a failures=()

want() {
  [ "${#FILTER[@]}" -eq 0 ] && return 0
  local n
  for n in "${FILTER[@]}"; do
    [ "$n" = "$1" ] && return 0
  done
  return 1
}

quote() {
  perl -e 'print quotemeta shift' "$1"
}

# Replace one hash in one app block. OLD is a Perl pattern containing
# one capture group for the assignment prefix; NEW replaces the hash value.
patch_block() {
  local name=$1 pattern=$2 replacement=$3 tmp
  tmp=$(mktemp "${PWD}/.apps.nix.XXXXXX") || return 1

  if ! NAME="$name" OLD="$pattern" NEW="$replacement" \
    perl -0777pe '
      my $found = 0;
      s{(^  \Q$ENV{NAME}\E = .*?)(?=^  [A-Za-z0-9_-]+ = |\z)}{
        my $block = $1;
        my $count = $block =~ s/$ENV{OLD}/$1$ENV{NEW}/;
        die "Expected one matching hash, found $count\n" unless $count == 1;
        $found++;
        $block;
      }mseg;
      die "Application block not found: $ENV{NAME}\n" unless $found == 1;
    ' apps.nix > "$tmp"; then
    rm -f "$tmp"
    return 1
  fi

  if cmp -s apps.nix "$tmp"; then
    rm -f "$tmp"
    return 1
  fi

  chmod --reference=apps.nix "$tmp" || {
    rm -f "$tmp"
    return 1
  }
  mv "$tmp" apps.nix || {
    rm -f "$tmp"
    return 1
  }
}

apply_fix() {
  [ -n "${WRITE:-}" ] || return 0

  local name=$1 kind=$2 system=$3 declared=$4 got=$5
  local selector replacement quoted

  if [ -n "$declared" ]; then
    quoted=$(quote "$declared")

    if [ "$kind" = icon ]; then
      selector="((?:icon[[:space:]]*=[[:space:]]*\\{[^}]*?hash[[:space:]]*=[[:space:]]*\"|icon\\.hash[[:space:]]*=[[:space:]]*\"))${quoted}"
    else
      selector="((?:$(quote "$system")\\.hash[[:space:]]*=[[:space:]]*\"|(?<![A-Za-z0-9_.])hash[[:space:]]*=[[:space:]]*\"))${quoted}"
    fi
    replacement=$got
  else
    if [ "$kind" = icon ]; then
      selector='((?:icon[[:space:]]*=[[:space:]]*\{[^}]*?hash[[:space:]]*=[[:space:]]*|icon\.hash[[:space:]]*=[[:space:]]*))null'
    else
      selector="((?:$(quote "$system")\\.hash[[:space:]]*=[[:space:]]*|(?<![A-Za-z0-9_.])hash[[:space:]]*=[[:space:]]*))null"
    fi
    replacement="\"$got\""
  fi

  if patch_block "$name" "$selector" "$replacement"; then
    echo "          written to apps.nix"
  else
    echo "          could not patch the intended source in apps.nix"
  fi
}

while IFS= read -r row; do
  name=$(jq -r '.name' <<<"$row")
  want "$name" || continue

  kind=$(jq -r '.kind' <<<"$row")
  system=$(jq -r '.system' <<<"$row")
  url=$(jq -r '.url' <<<"$row")
  declared=$(jq -r '.hash // ""' <<<"$row")
  label=$(printf '%-15s %-8s %-15s' "$name" "$kind" "$system")

  if ! got=$(
    "${NIX[@]}" store prefetch-file --json --hash-type sha256 "$url" \
      2>/tmp/check-hashes.err | jq -r '.hash'
  ) || [ -z "$got" ] || [ "$got" = null ]; then
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

  if ! norm=$(
    "${NIX[@]}" hash convert --hash-algo sha256 --to sri "$declared" 2>/dev/null
  ); then
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
