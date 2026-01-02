param(
    [switch]$Json,
    [switch]$Status,
    [switch]$Help
)

# Source common functions
$scriptDir = Split-Path -Parent $PSCommandPath
$commonPath = Join-Path $scriptDir "common.ps1"
. $commonPath

if ($Help) {
    Write-Host "Usage: create-new-task.ps1 [-Json] [-Status] [-Help]"
    Write-Host "  -Json    Output results in JSON format"
    Write-Host "  -Status  Include task status information"
    Write-Host "  -Help    Show this help message"
    exit 0
}

# Get paths
$repoRoot = Get-RepoRoot
$currentBranch = Get-CurrentBranch
$taskDir = Get-TaskDir $repoRoot $currentBranch
$tasksFile = Join-Path $taskDir "tasks.md"

# Ensure files exist
if (!(Test-Path $taskDir)) {
    New-Item -ItemType Directory -Path $taskDir -Force | Out-Null
}

if (!(Test-Path $tasksFile)) {
    New-Item -ItemType File -Path $tasksFile -Force | Out-Null
}

# Output results
if ($Json) {
    $result = @{
        TASK_DIR = $taskDir
        TASKS_FILE = $tasksFile
        BRANCH = $currentBranch
        STATUS_MODE = $Status
    }
    ConvertTo-Json-Simple $result | Write-Host
} else {
    Write-Host "TASK_DIR: $taskDir"
    Write-Host "TASKS_FILE: $tasksFile"
    Write-Host "BRANCH: $currentBranch"
}
