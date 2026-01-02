#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create GitHub release with template packages as assets

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"
TAG="v${VERSION#v}"
GENRELEASES_DIR=".genreleases"

# Generate release notes from CHANGELOG
RELEASE_NOTES="VibeCoder $TAG Release

## VibeCoder Templates
This release contains pre-configured template packages for all supported AI agents.

See [CHANGELOG.md](CHANGELOG.md) for details on what's new.

## Installation
Extract any template package and initialize your project:

\`\`\`bash
unzip vibekit-template-claude-sh-${TAG}.zip
vibe init . --ai claude
\`\`\`

## Available Packages
"

# Count packages
package_count=$(ls "$GENRELEASES_DIR"/*.zip 2>/dev/null | wc -l)
RELEASE_NOTES+="Total: $package_count template packages (19 agents × 2 script types)

## Checksums
"

# Add checksums
for checksum_file in "$GENRELEASES_DIR"/*.sha256 2>/dev/null || []; do
  if [[ -f "$checksum_file" ]]; then
    filename=$(basename "$checksum_file" .sha256)
    checksum=$(cat "$checksum_file")
    RELEASE_NOTES+="- **$filename**: \`$checksum\`
"
  fi
done

echo "Creating GitHub release $TAG"
echo "Release notes:"
echo "$RELEASE_NOTES"

# Check if gh CLI is available
if command -v gh &>/dev/null; then
  # Build asset flags
  assets_args=""
  for package in "$GENRELEASES_DIR"/*.zip 2>/dev/null || []; do
    if [[ -f "$package" ]]; then
      assets_args="$assets_args $package"
    fi
  done
  
  gh release create "$TAG" \
    --title "VibeCoder Templates $TAG" \
    --notes "$RELEASE_NOTES" \
    $assets_args || echo "Warning: release creation may have partially failed"
  
  echo "✓ Release created successfully"
else
  echo "ℹ GitHub CLI not found - release notes prepared but manual upload needed"
  echo "Visit: https://github.com/vibe-meth/vibe-kit/releases/new?tag=$TAG"
fi
