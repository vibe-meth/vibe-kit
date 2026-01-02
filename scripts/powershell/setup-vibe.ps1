param(
    [switch]$Json,
    [switch]$Help
)

# Source common functions
$scriptDir = Split-Path -Parent $PSCommandPath
$commonPath = Join-Path $scriptDir "common.ps1"
. $commonPath

if ($Help) {
    Write-Host "Usage: setup-vibe.ps1 [-Json] [-Help]"
    Write-Host "  -Json   Output results in JSON format"
    Write-Host "  -Help   Show this help message"
    exit 0
}

# Get paths and variables
$repoRoot = Get-RepoRoot
$currentBranch = Get-CurrentBranch
$hasGit = Get-HasGit
$taskDir = Get-TaskDir $repoRoot $currentBranch
$planFile = Join-Path $taskDir "plan.md"
$tasksFile = Join-Path $taskDir "tasks.md"

# Create task directory
if (!(Test-Path $taskDir)) {
    New-Item -ItemType Directory -Path $taskDir -Force | Out-Null
}

# Copy plan template if exists
$template = Join-Path $repoRoot "templates" "plan-template.md"
if (Test-Path $template) {
    Copy-Item $template $planFile -Force
} else {
    New-Item -ItemType File -Path $planFile -Force | Out-Null
}

# Output results
if ($Json) {
    $result = @{
        TASK_DIR = $taskDir
        PLAN_FILE = $planFile
        TASKS_FILE = $tasksFile
        BRANCH = $currentBranch
        HAS_GIT = $hasGit
    }
    ConvertTo-Json-Simple $result | Write-Host
} else {
    Write-Host "TASK_DIR: $taskDir"
    Write-Host "PLAN_FILE: $planFile"
    Write-Host "TASKS_FILE: $tasksFile"
    Write-Host "BRANCH: $currentBranch"
    Write-Host "HAS_GIT: $hasGit"
}
