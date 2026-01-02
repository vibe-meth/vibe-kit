#!/usr/bin/env bash
set -euo pipefail

# create-release-packages.sh
# Build VibeCoder template release archives for each supported AI assistant and script type.

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"
GENRELEASES_DIR=".genreleases"

# Remove version prefix if present
VERSION="${VERSION#v}"

mkdir -p "$GENRELEASES_DIR"

# Agent list
AGENTS=(claude gemini copilot cursor-agent qwen opencode codex windsurf kilocode auggie roo codebuddy qoder q amp shai bob)

echo "Building VibeCoder template packages for v$VERSION"

for agent in "${AGENTS[@]}"; do
  for script_type in sh ps; do
    # Create temp directory for agent-specific package
    temp_dir="$GENRELEASES_DIR/temp-${agent}-${script_type}"
    rm -rf "$temp_dir" || true
    mkdir -p "$temp_dir/.vibekit/templates"
    
    # Copy templates
    if [[ -d templates/commands ]]; then
      cp -r templates/commands "$temp_dir/.vibekit/" || true
    fi
    
    if [[ -d memory ]]; then
      cp -r memory "$temp_dir/.vibekit/" || true
    fi
    
    cp README.md "$temp_dir/" 2>/dev/null || true
    
    # Create agent-specific config
    cat > "$temp_dir/.vibekit/AGENT.txt" << EOF
Agent: $agent
Script Type: $script_type
Version: v$VERSION
EOF
    
    # Create archive
    archive_name="vibekit-template-${agent}-${script_type}-v${VERSION}.zip"
    
    if command -v zip &>/dev/null; then
      (cd "$temp_dir" && zip -r -q "../$archive_name" .) || true
      echo "✓ $archive_name"
    else
      echo "⚠ zip command not found, skipping $archive_name"
    fi
    
    # Generate checksum if archive exists
    if [[ -f "$GENRELEASES_DIR/$archive_name" ]]; then
      if command -v sha256sum &>/dev/null; then
        sha256sum "$GENRELEASES_DIR/$archive_name" | awk '{print $1}' > "$GENRELEASES_DIR/${archive_name}.sha256"
      fi
    fi
    
    # Cleanup
    rm -rf "$temp_dir" || true
  done
done

echo ""
echo "Release packages created in $GENRELEASES_DIR/"
if [[ -f "$GENRELEASES_DIR"/*.zip ]]; then
  ls -1 "$GENRELEASES_DIR"/*.zip 2>/dev/null | wc -l | xargs echo "Total packages:"
fi
