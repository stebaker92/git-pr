$branch = "feature1"
$base = "master"

Describe "GitLab" {
    Context "https pr" {
        it "should have correct url" {
            $url = git-pr-parse "https://gitlab.com/myuser/myrepo.git" $branch $base
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo/merge_requests/new?merge_request%5Bsource_branch%5D=feature1&merge_request%5Btarget_branch%5D=master"
        }
    }

    Context "https repo" {
        it "should have correct url" {
            $url = git-pr-parse "https://gitlab.com/myuser/myrepo" -repoOnly $true
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo"
        }
    }

    Context "ssh pr" {
        it "should have correct url" {
            $url = git-pr-parse "git@gitlab.com:myuser/myrepo.git" $branch $base
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo/merge_requests/new?merge_request%5Bsource_branch%5D=feature1&merge_request%5Btarget_branch%5D=master"
        }
    }

    Context "ssh repo" {
        it "should have correct url" {
            $url = git-pr-parse "git@gitlab.com:myuser/myrepo.git" -repoOnly $true
            $url + " is the url"
            $url | should be "https://gitlab.com/myuser/myrepo"
        }
    }
}

