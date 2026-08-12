#!/bin/sh
set -eu

patch_file=/tmp/ochartsng-https.patch
target=/usr/lib/avnav/plugins/ochartsng/plugin.py

[ -f "$target" ] || {
  echo "ERROR: expected O-ChartsNG file not found: $target" >&2
  exit 1
}

if grep -Fq 'registerUserApp("https://$HOST:4432/static/%s"' "$target"; then
  echo "O-ChartsNG HTTPS patch already present"
  exit 0
fi

grep -Fq 'registerUserApp("http://$HOST:%d/static/%s"' "$target" || {
  echo "ERROR: expected O-ChartsNG registration URL was not found; refusing an unsafe patch" >&2
  exit 1
}

patch --batch --forward -p0 < "$patch_file"

grep -Fq 'registerUserApp("https://$HOST:4432/static/%s"' "$target" || {
  echo "ERROR: patch completed without the expected HTTPS URL" >&2
  exit 1
}
