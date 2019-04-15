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
    elseif ($origin.Contains("azure") -eq $True) {
        $url = $origin 

        # Azure origin URL is different to Azure DevOps URL

        # Before
        # https://ssh.dev.azure.com/v3/$org/$project/$repo
        
        # After
        # https://$org.visualstudio.com/$project/_git/$repo

        $org = $url.split("/")[4]
        $project = $url.split("/")[5]
        $repo = $url.split("/")[6]
        
        $url = "https://$org.visualstudio.com/$project/_git/$repo/"

        $suffix = "pullrequestcreate?sourceRef=$branch&targetRef=$base"
        $url = $url + $suffix
    }
    elseif ($origin.Contains("visualstudio") -eq $True) {
        $url = $origin 

        # Azure origin URL is different to Azure DevOps URL

        # Before
        # evest@vs-ssh.visualstudio.com:v3/evest/eVestor%20Agile/ClientPortalV2
        
        # After
        # https://$org.visualstudio.com/$project/_git/$repo

        $org = $url.split("/")[2].Replace(".visualstudio.com", "")
        $project = $url.split("/")[4]
        $repo = $url.split("/")[6]
        
        $url = "https://$org.visualstudio.com/$project/_git/$repo/"

        $suffix = "pullrequestcreate?sourceRef=$branch&targetRef=$base"
        $url = $url + $suffix
    }
    else {
        Write-Error "$origin not supported"
        return;
    }

    "Opening url $url"
    Start-Process $url
}
