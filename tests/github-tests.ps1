Import-Module ".\git-pr.psm1" -Force

$global:branch = "feature1"
$global:base = "master"

Describe "GitHub" {
    Context "https pr" {
        it "should have correct url" {
            write-host "branch inside test is $global:branch"
            write-host $global:branch

            $url = git-pr-parse "https://github.com/myuser/myrepo.git" $branch $base
            $url | should -be "https://github.com/myuser/myrepo/compare/$base...$branch"
        }
    }

    # Context "https repo" {
    #     it "should have correct url" {
    #         $url = git-pr-parse "https://github.com/myuser/myrepo.git" -repoOnly $true
    #         $url | should -be "https://github.com/myuser/myrepo"
    #     }
    # }
    
    # Context "ssh pr" {
    #     it "should have correct url" {
    #         $url = git-pr-parse "git@github.com:myuser/myrepo.git" $branch $base
    #         $url | should -be "https://github.com/myuser/myrepo/compare/$base...$branch"
    #     }
    # }
    
    # Context "ssh repo" {
    #     it "should have correct url" {
    #         $url = git-pr-parse "git@github.com:myuser/myrepo.git" -repoOnly $true
    #         $url | should -be "https://github.com/myuser/myrepo"
    #     }
    # }
}

