#!/usr/bin/env bash

set -e

# Get script directory and load common functions
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get agent type (first argument or detect)
AGENT_TYPE="${1:-}"

# Get repository root
REPO_ROOT=$(get_repo_root)

# Common agent context files
VIBE_GUIDELINES="$REPO_ROOT/memory/vibe-guidelines.md"
VIBE_CONTEXT="$REPO_ROOT/memory/vibe-context.md"

# Agent-specific files
CLAUDE_FILE="$REPO_ROOT/.claude/system.md"
AMP_FILE="$REPO_ROOT/.agents/commands/context.md"
CURSOR_FILE="$REPO_ROOT/.cursor/rules.md"
COPILOT_FILE="$REPO_ROOT/.github/agents/system.md"

# Update function
update_agent_file() {
    local agent_file="$1"
    local agent_name="$2"
    
    if [[ ! -f "$agent_file" ]]; then
        mkdir -p "$(dirname "$agent_file")"
        touch "$agent_file"
    fi
    
    echo "[vibe] Updated context for $agent_name at $agent_file"
}

# If no agent specified, update all available
if [[ -z "$AGENT_TYPE" ]]; then
    [[ -f "$CLAUDE_FILE" ]] && update_agent_file "$CLAUDE_FILE" "Claude"
    [[ -f "$AMP_FILE" ]] && update_agent_file "$AMP_FILE" "Amp"
    [[ -f "$CURSOR_FILE" ]] && update_agent_file "$CURSOR_FILE" "Cursor"
    [[ -f "$COPILOT_FILE" ]] && update_agent_file "$COPILOT_FILE" "Copilot"
else
    case "$AGENT_TYPE" in
        claude)
            update_agent_file "$CLAUDE_FILE" "Claude"
            ;;
        amp)
            update_agent_file "$AMP_FILE" "Amp"
            ;;
        cursor)
            update_agent_file "$CURSOR_FILE" "Cursor"
            ;;
        copilot)
            update_agent_file "$COPILOT_FILE" "Copilot"
            ;;
        *)
            echo "Unknown agent: $AGENT_TYPE"
            exit 1
            ;;
    esac
fi

echo "[vibe] Agent context updated"
