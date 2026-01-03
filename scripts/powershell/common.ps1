# Common functions for VibeCoder scripts
# Set execution policy to allow script execution
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
} catch {
    # Ignore policy changes if not admin
}

function Get-RepoRoot {
    # Try git first with error handling
    try {
        $gitResult = git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $gitResult.Trim()
        }
    } catch {
        # Git command failed
    }
    
    # Fall back to script location
    try {
        $scriptDir = Split-Path -Parent $PSCommandPath -ErrorAction Stop
        $repoRoot = (Get-Item "$scriptDir/../../..").FullName
        return $repoRoot
    } catch {
        Write-Error "Cannot determine repository root"
        exit 1
    }
}

function Get-CurrentBranch {
    # Check environment variable first
    if ($env:VIBE_FEATURE) {
        return $env:VIBE_FEATURE
    }
    
    # Try git with error handling
    try {
        $gitResult = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $gitResult.Trim()
        }
    } catch {
        # Git command failed
    }
    
    # Default fallback
    return "main"
}

function Get-HasGit {
    try {
        $gitResult = git rev-parse --show-toplevel 2>$null
        return [bool]($LASTEXITCODE -eq 0 -and $gitResult)
    } catch {
        return $false
    }
}

function Get-TaskDir {
    param(
        [string]$RepoRoot,
        [string]$BranchName
    )
    return Join-Path $RepoRoot ".tasks" $BranchName
}

function ConvertTo-Json-Simple {
    param(
        [hashtable]$Data
    )
    $items = @()
    foreach ($key in $Data.Keys) {
        $items += "`"$key`":`"$($Data[$key])`""
    }
    return "{$($items -join ',')}"
}
