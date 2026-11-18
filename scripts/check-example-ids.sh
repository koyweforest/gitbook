#!/usr/bin/env bash
# Fails if documentation or API spec files contain example IDs that are not
# obvious placeholders.
#
# Placeholders accepted:
#   - UUIDs (optionally prefixed, e.g. mrc_) whose hex digits are all zeros
#     except up to the last 4: 00000000-0000-0000-0000-000000000001
#   - the RFC 4122 sample UUID 123e4567-e89b-12d3-a456-426614174000
#   - 24-hex ObjectIds that are all zeros except up to the last 4:
#     000000000000000000000001
# Exact values listed in .example-ids-allowlist (one per line, # comments) are
# also accepted.
#
# Usage: scripts/check-example-ids.sh [path ...]   (default: repository root)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ALLOWLIST="$ROOT/.example-ids-allowlist"
if [ "$#" -gt 0 ]; then TARGETS=("$@"); else TARGETS=("$ROOT"); fi

INCLUDES=(--include='*.md' --include='*.mdx' --include='*.json' --include='*.yaml' --include='*.yml')
EXCLUDES=(--exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.github)

UUID_RE='([a-z0-9]{2,8}_)?[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'
# ObjectIds only when quoted or in backticks, to avoid matching longer hashes.
OID_RE="[\"'\`][0-9a-f]{24}[\"'\`]"

is_allowlisted() {
  [ -f "$ALLOWLIST" ] && grep -vE '^\s*(#|$)' "$ALLOWLIST" | grep -qxF -- "$1"
}

is_placeholder() {
  local hex
  hex="$(printf '%s' "${1#*_}" | tr -d '-' | tr 'A-F' 'a-f')"
  [ "$hex" = "123e4567e89b12d3a456426614174000" ] && return 0
  [[ "$hex" =~ ^0+[0-9a-f]{0,4}$ ]] && [ "${#hex}" -ge 24 ] && return 0
  return 1
}

failures=0
while IFS= read -r hit; do
  [ -z "$hit" ] && continue
  value="${hit##*:}"
  location="${hit%:*}"
  value="${value//[\"\'\`]/}"
  if is_placeholder "$value" || is_allowlisted "$value"; then continue; fi
  echo "non-placeholder example id: $location: $value"
  failures=$((failures + 1))
done < <(
  grep -rnoIE "${INCLUDES[@]}" "${EXCLUDES[@]}" -- "$UUID_RE" "${TARGETS[@]}" || true
  grep -rnoIE "${INCLUDES[@]}" "${EXCLUDES[@]}" -- "$OID_RE" "${TARGETS[@]}" || true
)

if [ "$failures" -gt 0 ]; then
  echo
  echo "Found $failures example id(s) that are not placeholders."
  echo "Use 00000000-0000-0000-0000-000000000000 (keeping any prefix, e.g. mrc_) or"
  echo "000000000000000000000000 for ObjectIds. See CONTRIBUTING.md."
  exit 1
fi
echo "OK: all example ids are placeholders."
