function git-repo() { 
    $url = git remote get-url origin
    Write-Output "Opening: $url"
    Start-Process $url
}

function github-search() {
    Start-Process "https://github.com/search?q=term&unscoped_q=$a"
}

function git-pr {
    $baseOverride = $args[0]

    $base = git config --get git-pr.base

    if ($baseOverride -eq $null) {
        if ($base -eq $null) {
            Write-Host "Enter a base branch"
            $base = Read-Host 
            if ($base -eq $Null -or $base -eq "") {
                $base = "master"
            }
            git config git-pr.base $base
        }
    }
    else {
        Write-Output "override detected"
        Write-Output $baseOverride

        git config git-pr.base $baseOverride
        $base = $baseOverride
    }

    $branch = git symbolic-ref head --short

    $repodir = git rev-parse --show-toplevel

    $repo = Split-Path $repodir -Leaf

    $origin = git remote get-url origin

    if ($origin -eq $null) {
        Write-Error "no origin found"
        return;
    }

    # Remove the repo from the remote URL
    $split = $origin.split("/")
    $remoteWithoutRepoLength = $split.Length - 2;

    $split = $split[0..$remoteWithoutRepoLength]

    $remoteWithoutRepo = ($split -join "/") + "/"

    if ($origin.StartsWith("git@")) {
        # Remove the username
        $origin = $origin -replace ":", "/"

        $origin = $origin -replace "git@", "https://";
    }
    
    # Remove the .git suffix
    $origin = $origin.TrimEnd("git")
    $origin = $origin.TrimEnd(".")

    "origin is $origin"

    if ($origin.Contains("://github") -eq $True) {
        $url = $origin + "/compare/$base..." + $branch
        #+ "?w=1" #w=1 removes whitespace
    }
    elseif ($origin.Contains("://gitlab") -eq $True) {
        "this is a gitlab repo"
        $url = $origin + "/merge_requests/new?merge_request%5Bsource_branch%5D=$branch&merge_request%5Btarget_branch%5D=$base"
    }
    else {
        Write-Error "$origin not supported"
        return;
    }

    "Opening url $url"
    Start-Process $url
}
