Import-Module ".\git-pr.psm1" -Force

& ".\tests\azure-tests.ps1"
& ".\tests\github-tests.ps1"
& ".\tests\gitlab-tests.ps1"
