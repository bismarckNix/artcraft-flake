#! /usr/bin/env bash
# Verifies the declared hash of every package (per system) and icon in apps.nix.
#
# Usage:
#  tests/check-hashes.sh                 # check everything
#  tests/check-hashes.sh photocraft ...  # only these apps
#  FIX=1 tests/check-hashes.sh           # also print replacement lines for bad/missing hashes
#
# Exit code: 0 if all hashes match, 1 otherwise.
set -uo pipefail

cd "$(dirname "$0")/.."

NIX=(nix --extra-experimental-features "nix-command flakes")
FILTER=("$@")

if ! command -v jq >/dev/null; then
  echo "jq is required (nix shell nixpkgs#jq)" >&2
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
    continue
  fi

  # Normalise to SRI so base32 / hex / unpadded variants compare correctly.
  if ! norm=$("${NIX[@]}" hash convert --hash-algo sha256 --to sri "$declared" 2>/dev/null); then
    echo "INVALID $label malformed hash '$declared' (real: $got)"
    fail=$((fail + 1))
    failures+=("$label malformed")
    [ -n "${FIX:-}" ] && echo "          -> $got"
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
  fi
done < <(jq -c '.[]' <<<"$list")

echo
echo "passed: $ok  failed: $fail"
if [ "$fail" -gt 0 ]; then
  printf '  - %s\n' "${failures[@]}"
  exit 1
fi
