param(
    [string]$AgentType,
    [switch]$Help
)

# Source common functions
$scriptDir = Split-Path -Parent $PSCommandPath
$commonPath = Join-Path $scriptDir "common.ps1"
. $commonPath

if ($Help) {
    Write-Host "Usage: update-agent-context.ps1 [AgentType] [-Help]"
    Write-Host "  AgentType  claude, amp, cursor, copilot (optional - updates all if not specified)"
    Write-Host "  -Help      Show this help message"
    exit 0
}

# Get repository root
$repoRoot = Get-RepoRoot

# Common context files
$vibeGuidelines = Join-Path $repoRoot "memory" "vibe-guidelines.md"
$vibeContext = Join-Path $repoRoot "memory" "vibe-context.md"

# Agent-specific files
$claudeFile = Join-Path $repoRoot ".claude" "system.md"
$ampFile = Join-Path $repoRoot ".agents" "commands" "context.md"
$cursorFile = Join-Path $repoRoot ".cursor" "rules.md"
$copilotFile = Join-Path $repoRoot ".github" "agents" "system.md"

function Update-AgentFile {
    param(
        [string]$FilePath,
        [string]$AgentName
    )
    
    $dir = Split-Path -Parent $FilePath
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    
    if (!(Test-Path $FilePath)) {
        New-Item -ItemType File -Path $FilePath -Force | Out-Null
    }
    
    Write-Host "[vibe] Updated context for $AgentName at $FilePath"
}

# Update agents
if (-not $AgentType) {
    # Update all available
    if (Test-Path $claudeFile) { Update-AgentFile $claudeFile "Claude" }
    if (Test-Path $ampFile) { Update-AgentFile $ampFile "Amp" }
    if (Test-Path $cursorFile) { Update-AgentFile $cursorFile "Cursor" }
    if (Test-Path $copilotFile) { Update-AgentFile $copilotFile "Copilot" }
} else {
    switch ($AgentType.ToLower()) {
        "claude" { Update-AgentFile $claudeFile "Claude" }
        "amp" { Update-AgentFile $ampFile "Amp" }
        "cursor" { Update-AgentFile $cursorFile "Cursor" }
        "copilot" { Update-AgentFile $copilotFile "Copilot" }
        default {
            Write-Host "Unknown agent: $AgentType"
            exit 1
        }
    }
}

Write-Host "[vibe] Agent context updated"
