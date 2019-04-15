$branch = "feature1"
$base = "master"

Describe "GitLab" {
    Context "https" {
        it "should have correct url" {
            $url = git-pr-parse "https://gitlab.com/myuser/myrepo.git" $branch $base
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo/merge_requests/new?merge_request%5Bsource_branch%5D=feature1&merge_request%5Btarget_branch%5D=master"
        }
    }

    Context "ssh" {
        it "should have correct url" {
            $url = git-pr-parse "git@gitlab.com:myuser/myrepo.git" $branch $base
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo/merge_requests/new?merge_request%5Bsource_branch%5D=feature1&merge_request%5Btarget_branch%5D=master"
        }
    }
}

