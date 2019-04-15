# Import-Module ".\git-pr.psm1" -Force

$branch = "feature1"
$base = "master"

Describe "GitHub" {
    Context "https" {
        it "should have correct url" {
            $url = git-pr-parse "https://github.com/myuser/myrepo.git" $branch $base
            $url | should be "https://github.com/myuser/myrepo/compare/$base...$branch"
        }
    }

    Context "ssh" {
        it "should have correct url" {
            $url = git-pr-parse "git@github.com:myuser/myrepo.git" $branch $base
            $url | should be "https://github.com/myuser/myrepo/compare/$base...$branch"
        }
    }
}

