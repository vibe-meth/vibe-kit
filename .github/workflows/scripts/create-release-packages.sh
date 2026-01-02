#!/usr/bin/env bash
set -euo pipefail

# create-release-packages.sh
# Build VibeCoder template release archives for each supported AI assistant and script type.
# Usage: .github/workflows/scripts/create-release-packages.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"
GENRELEASES_DIR=".genreleases"
mkdir -p "$GENRELEASES_DIR"
rm -rf "$GENRELEASES_DIR"/* || true

# Agent list
AGENTS=(claude gemini copilot cursor-agent qwen opencode codex windsurf kilocode auggie roo codebuddy qoder q amp shai bob)

echo "Building VibeCoder template packages for $VERSION"

for agent in "${AGENTS[@]}"; do
  for script_type in sh ps; do
    # Create temp directory for agent-specific package
    temp_dir=$(mktemp -d)
    trap "rm -rf $temp_dir" EXIT
    
    # Create package structure
    mkdir -p "$temp_dir/.vibekit"
    mkdir -p "$temp_dir/.vibekit/templates/commands"
    
    # Copy templates
    cp -r templates/commands/* "$temp_dir/.vibekit/templates/commands/" 2>/dev/null || true
    cp -r templates/*.md "$temp_dir/.vibekit/templates/" 2>/dev/null || true
    cp -r memory "$temp_dir/.vibekit/" 2>/dev/null || true
    cp README.md "$temp_dir/" 2>/dev/null || true
    
    # Create agent context file
    cat > "$temp_dir/.vibekit/agent-config.md" << EOF
# VibeCoder Agent Configuration

**Agent**: $agent
**Script Type**: $script_type
**Version**: $VERSION

This package contains VibeCoder templates pre-configured for $agent.

To use:
1. Extract this archive to your project root
2. Initialize: \`vibe init . --ai $agent\`
3. Start planning: \`/$agent.plan\`
EOF
    
    # Create archive
    archive_name="vibekit-template-${agent}-${script_type}-${VERSION}.zip"
    cd "$temp_dir"
    zip -r "../$GENRELEASES_DIR/$archive_name" . > /dev/null 2>&1
    cd - > /dev/null
    
    # Generate checksum
    sha256sum "$GENRELEASES_DIR/$archive_name" | awk '{print $1}' > "$GENRELEASES_DIR/${archive_name}.sha256"
    
    echo "Created $archive_name"
  done
done

echo "Release packages created in $GENRELEASES_DIR/"
ls -lh "$GENRELEASES_DIR"/*.zip 2>/dev/null | wc -l | xargs echo "Total packages:"
