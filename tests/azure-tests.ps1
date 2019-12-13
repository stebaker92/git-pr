$branch = "feature1"
$base = "master"

Describe "Azure" {
    Context "https" {
        it "should have correct url"{
            $url = git-pr-parse "https://myorg.visualstudio.com/DefaultCollection/myproject/_git/myrepo" $branch $base
            $url | should be "https://dev.azure.com/myorg/myproject/_git/myrepo/pullrequestcreate?sourceRef=$branch&targetRef=$base"
        }
    }
    Context "ssh - org prefix" {
        it "should have correct url"{
            $url = git-pr-parse "myorg@vs-ssh.visualstudio.com:v3/myorg/myproject/myrepo" $branch $base
            $url | should be "https://dev.azure.com/myorg/myproject/_git/myrepo/pullrequestcreate?sourceRef=$branch&targetRef=$base"
        }
    }
    Context "ssh - git prefix" {
        it "should have correct url"{
            $url = git-pr-parse "git@ssh.dev.azure.com:v3/myorg/myproject/myrepo" $branch $base
            $url | should be "https://dev.azure.com/myorg/myproject/_git/myrepo/pullrequestcreate?sourceRef=$branch&targetRef=$base"
        }
    }
}

