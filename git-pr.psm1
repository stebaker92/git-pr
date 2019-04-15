function git-repo() { 
    $url = git remote get-url origin
    Write-Host "Opening: $url"
    Start-Process $url
}

function github-search() {
    Start-Process "https://github.com/search?q=term&unscoped_q=$a"
}

function git-pr {
    # Use write-host instead of Write Output so we don't pipe anything out 
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
        Write-Host "override detected"
        Write-Host $baseOverride

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
    
    # Remove the .git suffix
    $origin = $origin.TrimEnd("git")
    $origin = $origin.TrimEnd(".")

    Write-Host "origin is $origin"

    if ($origin.Contains("://github") -eq $True) {
        if ($origin.StartsWith("git@")) {
            # Remove the username
            $origin = $origin -replace ":", "/"
    
            $origin = $origin -replace "git@", "https://";
        }

        $url = $origin + "/compare/$base..." + $branch
        #+ "?w=1" #w=1 removes whitespace
    }
    elseif ($origin.Contains("://gitlab") -eq $True) {
        if ($origin.StartsWith("git@")) {
            # Remove the username
            $origin = $origin -replace ":", "/"
    
            $origin = $origin -replace "git@", "https://";
        }

        "this is a gitlab repo"
        $url = $origin + "/merge_requests/new?merge_request%5Bsource_branch%5D=$branch&merge_request%5Btarget_branch%5D=$base"
    }
    elseif ($origin.Contains("visualstudio.com") -eq $True -or $origin.Contains("azure.com")) {
        # Azure DevOps has random remote formats so this is a little messy.
        
        if ($origin -match "^(\w+)(\@{1})") {
            # This is SSH

            # Input URL format(s):
            # git@ssh.dev.azure.com:v3/$org/$project/$repo
            # $org@vs-ssh.visualstudio.com:v3/$org/$project/$repo

            $url = $origin 

            # Azure origin URL is sometimes different to Azure DevOps URL
            
            $org = $url.split("/")[1]
            $project = $url.split("/")[2]
            $repo = $url.split("/")[3]
        }
        else {
            # This is HTTPS

            # Input URL format:
            # https://$org.visualstudio.com/DefaultCollection/$project/_git/$repo

            $url = $origin 

            $org = $url.split("/")[2].split(".")[0]
            $project = $url.split("/")[4]
            $repo = $url.split("/")[6]
        }
        
        # Expected URL Format:
        # https://$org.visualstudio.com/$project/_git/$repo

        $url = "https://$org.visualstudio.com/$project/_git/$repo/"

        $suffix = "pullrequestcreate?sourceRef=$branch&targetRef=$base"
        $url = $url + $suffix
    }
    else {
        Write-Error "$origin not supported"
        return;
    }
    
    Write-Host "Opening url $url"

        Start-Process $url
}
