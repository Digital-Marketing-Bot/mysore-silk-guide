#!/usr/bin/env bash
# Usage: ./set_base_url.sh https://<user>.github.io/mysore-silk-guide
# Replaces BASE_URL_PLACEHOLDER in all HTML, sitemap.xml and robots.txt (no trailing slash).
set -euo pipefail
[ $# -eq 1 ] || { echo "Usage: $0 https://<user>.github.io/mysore-silk-guide" >&2; exit 1; }
URL="${1%/}"
cd "$(dirname "$0")"
FILES=$(grep -rl --include='*.html' --include='sitemap.xml' --include='robots.txt' 'BASE_URL_PLACEHOLDER' . || true)
[ -n "$FILES" ] || { echo "No placeholder found (already set?)"; exit 0; }
for f in $FILES; do sed -i "s#BASE_URL_PLACEHOLDER#${URL}#g" "$f"; echo "updated $f"; done
