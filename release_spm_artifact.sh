#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./release_spm_artifact.sh 0.1.0
#   ./release_spm_artifact.sh 0.1.0 --upload
#
# This script must run from StringJetSPM and updates Package.swift to use
# a GitHub release-hosted xcframework zip + checksum.

VERSION="${1:-}"
UPLOAD="${2:-}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> [--upload]"
  exit 1
fi

TAG="v${VERSION}"
ASSET_NAME="sdkKit.xcframework.zip"
RELEASE_URL="https://github.com/StringJet-i18n/stringjet-swift-sdk/releases/download/${TAG}/${ASSET_NAME}"

if [[ ! -d "XCFrameworks/sdkKit.xcframework" ]]; then
  echo "Missing XCFrameworks/sdkKit.xcframework"
  exit 1
fi

rm -f "${ASSET_NAME}"
ditto -c -k --sequesterRsrc --keepParent "XCFrameworks/sdkKit.xcframework" "${ASSET_NAME}"
CHECKSUM="$(swift package compute-checksum "${ASSET_NAME}")"

python3 - <<'PY' "$RELEASE_URL" "$CHECKSUM"
from pathlib import Path
import re
import sys

url = sys.argv[1]
checksum = sys.argv[2]
path = Path("Package.swift")
src = path.read_text()
src = re.sub(r'url:\s*"[^"]+"', f'url: "{url}"', src, count=1)
src = re.sub(r'checksum:\s*"[^"]+"', f'checksum: "{checksum}"', src, count=1)
path.write_text(src)
PY

echo "Prepared ${ASSET_NAME}"
echo "Checksum: ${CHECKSUM}"
echo "Updated Package.swift URL/checksum for ${TAG}"

if [[ "${UPLOAD}" == "--upload" ]]; then
  gh release create "${TAG}" "${ASSET_NAME}" --title "${TAG}" --notes "Release ${TAG}"
  echo "Uploaded ${ASSET_NAME} to GitHub release ${TAG}"
else
  echo "Dry-run complete. Re-run with --upload to publish asset."
fi
