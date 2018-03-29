$origin = git remote get-url origin

$baseOverride = $args[0]

$base = git config --get git-pr.base

if ($baseOverride -eq $null) {
    if ($base -eq $null) {
        Write-Host "Enter a base branch"
        $base = Read-Host 
		if ($base -eq $Null){
			$base = "master"
		}
        git config git-pr.base $base
    }
}
else {
    echo "override detected"
    echo $baseOverride
	
    git config git-pr.base $baseOverride
    $base = $baseOverride
}

$branch = git symbolic-ref head --short

$repodir = git rev-parse --show-toplevel

$repo = Split-Path $repodir -Leaf

# Remove the repo from the remote URL
$split = $origin.split("/")
$remoteWithoutRepoLength = $split.Length - 2;

$split = $split[0..$remoteWithoutRepoLength]

$remoteWithoutRepo = ($split -join "/") + "/"

if ($origin.Contains("://github") -eq $True) {	
	$url = $remoteWithoutRepo + $repo + "/compare/$base..." + $branch 
	#+ "?w=1" #w=1 removes whitespace

} elseif ($origin.Contains("://gitlab") -eq $True) {
	"this is a gitlab repo"
	$url = $remoteWithoutRepo + $repo + "/merge_requests/new?merge_request%5Bsource_branch%5D=$branch&merge_request%5Btarget_branch%5D=master"

} else {
	Write-Error "$origin not supported"
}

Start-Process $url
