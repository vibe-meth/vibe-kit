#!/usr/bin/env bash
set -euo pipefail

# create-release-packages.sh
# Build VibeCoder template release archives for each supported AI assistant and script type.

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"
# Remove version prefix if present
VERSION="${VERSION#v}"

GENRELEASES_DIR=".genreleases"
mkdir -p "$GENRELEASES_DIR"

# Agent list
AGENTS=(claude gemini copilot cursor-agent qwen opencode codex windsurf kilocode auggie roo codebuddy qoder q amp shai bob)

echo "Building VibeCoder template packages for v$VERSION"

rewrite_paths() {
  sed -E \
    -e 's@(/?)memory/@.vibekit/memory/@g' \
    -e 's@(/?)scripts/@.vibekit/scripts/@g' \
    -e 's@(/?)templates/@.vibekit/templates/@g'
}

generate_commands() {
  local agent=$1 ext=$2 arg_format=$3 output_dir=$4 script_variant=$5
  mkdir -p "$output_dir"
  
  for template in templates/commands/*.md; do
    [[ -f "$template" ]] || continue
    local name description script_command agent_script_command body
    name=$(basename "$template" .md)
    
    # Normalize line endings
    file_content=$(tr -d '\r' < "$template")
    
    # Extract description from YAML frontmatter
    description=$(printf '%s\n' "$file_content" | awk '/^description:/ {sub(/^description:[[:space:]]*/, ""); print; exit}')
    
    # Extract script command from YAML frontmatter
    script_command=$(printf '%s\n' "$file_content" | awk -v sv="$script_variant" '/^[[:space:]]*'"$script_variant"':[[:space:]]*/ {sub(/^[[:space:]]*'"$script_variant"':[[:space:]]*/, ""); print; exit}')
    
    if [[ -z $script_command ]]; then
      echo "Warning: no script command found for $script_variant in $template" >&2
      script_command="(Missing script command for $script_variant)"
    fi
    
    # Extract agent_script command from YAML frontmatter if present
    agent_script_command=$(printf '%s\n' "$file_content" | awk '
      /^agent_scripts:$/ { in_agent_scripts=1; next }
      in_agent_scripts && /^[[:space:]]*'"$script_variant"':[[:space:]]*/ {
        sub(/^[[:space:]]*'"$script_variant"':[[:space:]]*/, "")
        print
        exit
      }
      in_agent_scripts && /^[a-zA-Z]/ { in_agent_scripts=0 }
    ')
    
    # Replace {SCRIPT} placeholder with the script command
    body=$(printf '%s\n' "$file_content" | sed "s|{SCRIPT}|${script_command}|g")
    
    # Replace {AGENT_SCRIPT} placeholder with the agent script command if found
    if [[ -n $agent_script_command ]]; then
      body=$(printf '%s\n' "$body" | sed "s|{AGENT_SCRIPT}|${agent_script_command}|g")
    fi
    
    # Remove the scripts: and agent_scripts: sections from frontmatter while preserving YAML structure
    body=$(printf '%s\n' "$body" | awk '
      /^---$/ { print; if (++dash_count == 1) in_frontmatter=1; else in_frontmatter=0; next }
      in_frontmatter && /^scripts:$/ { skip_scripts=1; next }
      in_frontmatter && /^agent_scripts:$/ { skip_scripts=1; next }
      in_frontmatter && /^[a-zA-Z].*:/ && skip_scripts { skip_scripts=0 }
      in_frontmatter && skip_scripts && /^[[:space:]]/ { next }
      { print }
    ')
    
    # Apply other substitutions
    body=$(printf '%s\n' "$body" | sed "s/{ARGS}/$arg_format/g" | sed "s/__AGENT__/$agent/g" | rewrite_paths)
    
    case $ext in
      toml)
        body=$(printf '%s\n' "$body" | sed 's/\\/\\\\/g')
        { echo "description = \"$description\""; echo; echo "prompt = \"\"\""; echo "$body"; echo "\"\"\""; } > "$output_dir/vibekit.$name.$ext" ;;
      md)
        echo "$body" > "$output_dir/vibekit.$name.$ext" ;;
    esac
  done
}

build_variant() {
  local agent=$1 script=$2
  local base_dir="$GENRELEASES_DIR/temp-${agent}-${script}"
  
  echo "Building $agent ($script) package..."
  rm -rf "$base_dir" || true
  mkdir -p "$base_dir/.vibekit"
  
  # Copy memory
  [[ -d memory ]] && { cp -r memory "$base_dir/.vibekit/"; }
  
  # Copy only the relevant script variant
  if [[ -d scripts ]]; then
    mkdir -p "$base_dir/.vibekit/scripts"
    case $script in
      sh)
        [[ -d scripts/bash ]] && { cp -r scripts/bash "$base_dir/.vibekit/scripts/"; }
        ;;
      ps)
        [[ -d scripts/powershell ]] && { cp -r scripts/powershell "$base_dir/.vibekit/scripts/"; }
        ;;
    esac
  fi
  
  # Copy templates (non-commands)
  if [[ -d templates ]]; then
    mkdir -p "$base_dir/.vibekit/templates"
    find templates -type f -not -path "templates/commands/*" -exec cp --parents {} "$base_dir/.vibekit/" \;
  fi
  
  # Copy README
  [[ -f README.md ]] && cp README.md "$base_dir/"
  
  # Generate agent-specific commands
  # NOTE: We substitute {ARGS} internally. Outward tokens differ intentionally:
  #   * Markdown/prompt (claude, copilot, cursor-agent, etc.): $ARGUMENTS
  #   * TOML (gemini, qwen): {{args}}
  
  case $agent in
    claude)
      mkdir -p "$base_dir/.claude/commands"
      generate_commands claude md "\$ARGUMENTS" "$base_dir/.claude/commands" "$script" ;;
    gemini)
      mkdir -p "$base_dir/.gemini/commands"
      generate_commands gemini toml "{{args}}" "$base_dir/.gemini/commands" "$script" ;;
    copilot)
      mkdir -p "$base_dir/.github/agents"
      generate_commands copilot md "\$ARGUMENTS" "$base_dir/.github/agents" "$script" ;;
    cursor-agent)
      mkdir -p "$base_dir/.cursor/commands"
      generate_commands cursor-agent md "\$ARGUMENTS" "$base_dir/.cursor/commands" "$script" ;;
    qwen)
      mkdir -p "$base_dir/.qwen/commands"
      generate_commands qwen toml "{{args}}" "$base_dir/.qwen/commands" "$script" ;;
    opencode)
      mkdir -p "$base_dir/.opencode/commands"
      generate_commands opencode md "\$ARGUMENTS" "$base_dir/.opencode/commands" "$script" ;;
    codex)
      mkdir -p "$base_dir/.codex/commands"
      generate_commands codex md "\$ARGUMENTS" "$base_dir/.codex/commands" "$script" ;;
    windsurf)
      mkdir -p "$base_dir/.windsurf/workflows"
      generate_commands windsurf md "\$ARGUMENTS" "$base_dir/.windsurf/workflows" "$script" ;;
    kilocode)
      mkdir -p "$base_dir/.kilocode/rules"
      generate_commands kilocode md "\$ARGUMENTS" "$base_dir/.kilocode/rules" "$script" ;;
    auggie)
      mkdir -p "$base_dir/.augment/rules"
      generate_commands auggie md "\$ARGUMENTS" "$base_dir/.augment/rules" "$script" ;;
    roo)
      mkdir -p "$base_dir/.roo/rules"
      generate_commands roo md "\$ARGUMENTS" "$base_dir/.roo/rules" "$script" ;;
    codebuddy)
      mkdir -p "$base_dir/.codebuddy/commands"
      generate_commands codebuddy md "\$ARGUMENTS" "$base_dir/.codebuddy/commands" "$script" ;;
    qoder)
      mkdir -p "$base_dir/.qoder/commands"
      generate_commands qoder md "\$ARGUMENTS" "$base_dir/.qoder/commands" "$script" ;;
    q)
      mkdir -p "$base_dir/.amazonq/prompts"
      generate_commands q md "\$ARGUMENTS" "$base_dir/.amazonq/prompts" "$script" ;;
    amp)
      mkdir -p "$base_dir/.agents/commands"
      generate_commands amp md "\$ARGUMENTS" "$base_dir/.agents/commands" "$script" ;;
    shai)
      mkdir -p "$base_dir/.shai/commands"
      generate_commands shai md "\$ARGUMENTS" "$base_dir/.shai/commands" "$script" ;;
    bob)
      mkdir -p "$base_dir/.bob/commands"
      generate_commands bob md "\$ARGUMENTS" "$base_dir/.bob/commands" "$script" ;;
  esac
  
  # Create archive
  archive_name="vibekit-template-${agent}-${script}-v${VERSION}.zip"
  (cd "$base_dir" && zip -r -q "../$archive_name" .) || true
  echo "✓ $archive_name"
  
  # Generate checksum
  if [[ -f "$GENRELEASES_DIR/$archive_name" ]]; then
    if command -v sha256sum &>/dev/null; then
      sha256sum "$GENRELEASES_DIR/$archive_name" | awk '{print $1}' > "$GENRELEASES_DIR/${archive_name}.sha256"
    fi
  fi
  
  # Cleanup
  rm -rf "$base_dir" || true
}

for agent in "${AGENTS[@]}"; do
  for script_type in sh ps; do
    build_variant "$agent" "$script_type"
  done
done

echo ""
echo "Release packages created in $GENRELEASES_DIR/"
if [[ -f "$GENRELEASES_DIR"/*.zip ]]; then
  ls -1 "$GENRELEASES_DIR"/*.zip 2>/dev/null | wc -l | xargs echo "Total packages:"
fi
