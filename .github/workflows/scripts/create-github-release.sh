#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create GitHub release with template packages as assets

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"
TAG="v${VERSION}"
GENRELEASES_DIR=".genreleases"

# Generate release notes from CHANGELOG
RELEASE_NOTES="VibeCoder $VERSION Release

## What's New
See [CHANGELOG.md](CHANGELOG.md) for details.

## Installation
Extract any template package and use with your preferred AI agent:

\`\`\`bash
unzip vibekit-template-claude-sh-${VERSION}.zip
vibe init . --ai claude
\`\`\`

## Package Checksums
"

# Add checksums to release notes
for checksum_file in "$GENRELEASES_DIR"/*.sha256; do
  if [[ -f "$checksum_file" ]]; then
    filename=$(basename "$checksum_file" .sha256)
    checksum=$(cat "$checksum_file")
    RELEASE_NOTES+="
\`$filename\`
\`\`\`
sha256: $checksum
\`\`\`
"
  fi
done

# Create GitHub release with assets
echo "Creating GitHub release $TAG"

# Upload all packages
assets=()
for package in "$GENRELEASES_DIR"/*.zip; do
  if [[ -f "$package" ]]; then
    assets+=("--attach" "$package")
  fi
done

# Use GitHub CLI if available, otherwise use curl
if command -v gh &> /dev/null; then
  gh release create "$TAG" \
    --title "VibeCoder $VERSION" \
    --notes "$RELEASE_NOTES" \
    "${assets[@]}"
else
  echo "GitHub CLI not found. Release notes:"
  echo "$RELEASE_NOTES"
  echo "Please upload packages manually to: https://github.com/vibe-meth/vibe-kit/releases/new?tag=$TAG"
fi
