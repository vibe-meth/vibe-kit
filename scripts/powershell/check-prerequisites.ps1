param(
    [switch]$Json,
    [switch]$Help
)

# Source common functions
$scriptDir = Split-Path -Parent $PSCommandPath
$commonPath = Join-Path $scriptDir "common.ps1"
. $commonPath

if ($Help) {
    Write-Host "Usage: check-prerequisites.ps1 [-Json] [-Help]"
    Write-Host "  -Json   Output results in JSON format"
    Write-Host "  -Help   Show this help message"
    exit 0
}

# Check prerequisites
$repoRoot = Get-RepoRoot
$currentBranch = Get-CurrentBranch
$hasGit = Get-HasGit
$taskDir = Get-TaskDir $repoRoot $currentBranch

# Check if tasks file exists
$tasksFile = Join-Path $taskDir "tasks.md"
$hasTasks = Test-Path $tasksFile

# Output results
if ($Json) {
    $result = @{
        REPO_ROOT = $repoRoot
        TASK_DIR = $taskDir
        HAS_GIT = $hasGit
        HAS_TASKS = $hasTasks
    }
    ConvertTo-Json-Simple $result | Write-Host
} else {
    Write-Host "REPO_ROOT: $repoRoot"
    Write-Host "TASK_DIR: $taskDir"
    Write-Host "HAS_GIT: $hasGit"
    Write-Host "HAS_TASKS: $hasTasks"
}
