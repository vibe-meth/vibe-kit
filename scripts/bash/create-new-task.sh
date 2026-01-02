#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
STATUS_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) 
            JSON_MODE=true 
            ;;
        --status)
            STATUS_MODE=true
            ;;
        --help|-h) 
            echo "Usage: $0 [--json] [--status]"
            echo "  --json      Output results in JSON format"
            echo "  --status    Include task status information"
            echo "  --help      Show this help message"
            exit 0 
            ;;
        *) 
            ARGS+=("$arg") 
            ;;
    esac
done

# Get script directory and load common functions
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get paths
REPO_ROOT=$(get_repo_root)
CURRENT_BRANCH=$(get_current_branch)
TASK_DIR=$(get_task_dir "$REPO_ROOT" "$CURRENT_BRANCH")
TASKS_FILE="$TASK_DIR/tasks.md"

# Ensure files exist
mkdir -p "$TASK_DIR"
touch "$TASKS_FILE"

# Output results
if [[ "$JSON_MODE" == "true" ]]; then
    printf '{"TASK_DIR":"%s","TASKS_FILE":"%s","BRANCH":"%s","STATUS_MODE":"%s"}\n' \
        "$TASK_DIR" "$TASKS_FILE" "$CURRENT_BRANCH" "$STATUS_MODE"
else
    echo "TASK_DIR: $TASK_DIR"
    echo "TASKS_FILE: $TASKS_FILE"
    echo "BRANCH: $CURRENT_BRANCH"
fi
