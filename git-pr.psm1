function git-repo() { 
    $origin = git remote get-url origin
    $url = git-pr-parse -origin $origin -repoOnly $true
    Write-Host "Opening: $url"
    Start-Process $url
}

function github-search() {
    Start-Process "https://github.com/search?q=term&unscoped_q=$a"
}

function git-pr-parse
{
    Param
    (
        [string]$origin, [string]$branch, [string]$base, [bool]$repoOnly
    )

    write-host "origin: $origin"
    write-host "base: $base"
    write-host "branch: $branch"

    # Remove the .git suffix
    $origin = $origin -replace "\.git+$"

    if ($origin.Contains("github") -eq $True) {
        Write-Host "this is a github repo"

        if ($origin.StartsWith("git@")) {
            # Remove the username
            $origin = $origin -replace ":", "/"
    
            $origin = $origin -replace "git@", "https://";
        }

        if ($repoOnly -eq $true) {return $origin}

        $url = "$origin/compare/$base...$branch"
        #+ "?w=1" #w=1 removes whitespace
    }
    elseif ($origin.Contains("gitlab.com") -eq $True) {
        Write-Host "this is a gitlab repo"

        if ($origin.StartsWith("git@")) {
            # Remove the username
            $origin = $origin -replace ":", "/"
    
            $origin = $origin -replace "git@", "https://";
        }
        
        if ($repoOnly -eq $true) {return $origin}

        $url = $origin + "/merge_requests/new?merge_request%5Bsource_branch%5D=$branch&merge_request%5Btarget_branch%5D=$base"
    }
    elseif ($origin.Contains("visualstudio.com") -eq $True -or $origin.Contains("azure.com")) {
        Write-Host "this is an azure repo"

        # Azure DevOps has random remote formats so this gets a little messy.
        
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
        elseif ($origin.StartsWith("http")) {
            # This is HTTPS

            # Input URL formats can be :
            # https://$org.visualstudio.com/DefaultCollection/$project/_git/$repo
            # https://org@dev.azure.com/org/project/_git/repo

            $url = $origin 

            if ($url -contains "@dev") {
                $org = $url.split("/")[2].Split("@dev")[0]
            } else {
                $org = $url.split("/")[2].split(".")[0]
            }
            $project = $url.split("/")[4]
            $repo = $url.split("/")[6]
        }
        
        # Expected URL Format:
        # https://$org.visualstudio.com/$project/_git/$repo


        $url = "https://dev.azure.com/$org/$project/_git/$repo/"

        if ($repoOnly -eq $true) {return $url}

        $suffix = "pullrequestcreate?sourceRef=$branch&targetRef=$base"
        $url = $url + $suffix
    }
    else {
        Write-Error "$origin not supported"
        return;
    }

    return $url;
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

    [string]$url = git-pr-parse $origin $branch $base

    Write-Host "Opening url $url"

    Start-Process $url
}
