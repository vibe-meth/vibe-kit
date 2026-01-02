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

# Get all paths and variables
REPO_ROOT=$(get_repo_root)
CURRENT_BRANCH=$(get_current_branch)
HAS_GIT=$(has_git && echo "true" || echo "false")
TASK_DIR=$(get_task_dir "$REPO_ROOT" "$CURRENT_BRANCH")
PLAN_FILE="$TASK_DIR/plan.md"
TASKS_FILE="$TASK_DIR/tasks.md"

# Ensure the task directory exists
mkdir -p "$TASK_DIR"

# Copy plan template if it exists
TEMPLATE="$REPO_ROOT/templates/plan-template.md"
if [[ -f "$TEMPLATE" ]]; then
    cp "$TEMPLATE" "$PLAN_FILE"
else
    # Create a basic plan file if template doesn't exist
    touch "$PLAN_FILE"
fi

# Output results
if [[ "$JSON_MODE" == "true" ]]; then
    printf '{"TASK_DIR":"%s","PLAN_FILE":"%s","TASKS_FILE":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$TASK_DIR" "$PLAN_FILE" "$TASKS_FILE" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "TASK_DIR: $TASK_DIR"
    echo "PLAN_FILE: $PLAN_FILE"
    echo "TASKS_FILE: $TASKS_FILE"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi
