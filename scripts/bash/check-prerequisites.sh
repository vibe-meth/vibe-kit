#!/usr/bin/env bash

set -e

# Parse command line arguments
JSON_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json) 
            JSON_MODE=true 
            ;;
        --help|-h) 
            echo "Usage: $0 [--json]"
            echo "  --json    Output results in JSON format"
            echo "  --help    Show this help message"
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

# Check prerequisites
REPO_ROOT=$(get_repo_root)
CURRENT_BRANCH=$(get_current_branch)
HAS_GIT=$(has_git && echo "true" || echo "false")
TASK_DIR=$(get_task_dir "$REPO_ROOT" "$CURRENT_BRANCH")

# Check if tasks file exists
TASKS_FILE="$TASK_DIR/tasks.md"
HAS_TASKS="false"
[[ -f "$TASKS_FILE" ]] && HAS_TASKS="true"

# Output results
if [[ "$JSON_MODE" == "true" ]]; then
    printf '{"REPO_ROOT":"%s","TASK_DIR":"%s","HAS_GIT":"%s","HAS_TASKS":"%s"}\n' \
        "$REPO_ROOT" "$TASK_DIR" "$HAS_GIT" "$HAS_TASKS"
else
    echo "REPO_ROOT: $REPO_ROOT"
    echo "TASK_DIR: $TASK_DIR"
    echo "HAS_GIT: $HAS_GIT"
    echo "HAS_TASKS: $HAS_TASKS"
fi
