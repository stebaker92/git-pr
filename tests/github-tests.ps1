# Import-Module ".\git-pr.psm1" -Force

$branch = "feature1"
$base = "master";

Describe "GitHub" {
    Context "https pr" {
        it "should have correct url" {
            echo "branch inside test is $branch"
            echo "base inside test is $base"

            $base = "master";
            echo "base inside test is $base"

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

