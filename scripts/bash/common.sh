#!/usr/bin/env bash
# Common functions and variables for VibeCoder scripts

# Get repository root, with fallback for non-git repositories
get_repo_root() {
    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        git rev-parse --show-toplevel
    else
        # Fall back to script location for non-git repos
        local script_dir="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        (cd "$script_dir/../../.." && pwd)
    fi
}

# Get current branch, with fallback for non-git repositories
get_current_branch() {
    # First check if VIBE_FEATURE environment variable is set
    if [[ -n "${VIBE_FEATURE:-}" ]]; then
        echo "$VIBE_FEATURE"
        return
    fi

    # Then check git if available
    if git rev-parse --abbrev-ref HEAD >/dev/null 2>&1; then
        git rev-parse --abbrev-ref HEAD
        return
    fi

    # For non-git repos, try to find the latest task directory
    local repo_root=$(get_repo_root)
    local tasks_dir="$repo_root/.tasks"

    if [[ -d "$tasks_dir" ]]; then
        local latest_task=""
        local highest=0

        for dir in "$tasks_dir"/*; do
            if [[ -d "$dir" ]]; then
                local dirname=$(basename "$dir")
                if [[ "$dirname" =~ ^([0-9]{3})- ]]; then
                    local number=${BASH_REMATCH[1]}
                    number=$((10#$number))
                    if [[ "$number" -gt "$highest" ]]; then
                        highest=$number
                        latest_task=$dirname
                    fi
                fi
            fi
        done

        if [[ -n "$latest_task" ]]; then
            echo "$latest_task"
            return
        fi
    fi

    echo "main"  # Final fallback
}

# Check if we have git available
has_git() {
    git rev-parse --show-toplevel >/dev/null 2>&1
}

# Get task directory
get_task_dir() {
    local repo_root="$1"
    local branch_name="$2"
    echo "$repo_root/.tasks/$branch_name"
}

# Output helper for both normal and JSON modes
output_result() {
    local json_mode="$1"
    local key="$2"
    local value="$3"
    
    if [[ "$json_mode" == "true" ]]; then
        echo -n "\"$key\":\"$value\","
    else
        echo "$key: $value"
    fi
}

# Finalize JSON output
finalize_json() {
    local json_str="$1"
    # Remove trailing comma and wrap in braces
    json_str="${json_str%,}"
    echo "{$json_str}"
}
