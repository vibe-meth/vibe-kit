# Common functions for VibeCoder scripts

function Get-RepoRoot {
    # Try git first
    if ((git rev-parse --show-toplevel 2>$null)) {
        git rev-parse --show-toplevel
        return
    }
    
    # Fall back to script location
    $scriptDir = Split-Path -Parent $PSCommandPath
    $repoRoot = (Get-Item "$scriptDir/../../..").FullName
    return $repoRoot
}

function Get-CurrentBranch {
    # Check environment variable first
    if ($env:VIBE_FEATURE) {
        return $env:VIBE_FEATURE
    }
    
    # Try git
    if ((git rev-parse --abbrev-ref HEAD 2>$null)) {
        return git rev-parse --abbrev-ref HEAD
    }
    
    # Default fallback
    return "main"
}

function Get-HasGit {
    $result = git rev-parse --show-toplevel 2>$null
    return [bool]$result
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
