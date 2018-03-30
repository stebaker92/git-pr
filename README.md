# git-pr

Create PR's on GitHub with ease from the command line. Just run
`pr` 
or `git pr`
from your shell (whilst in a git directory) to open your browser ready to create a pull request

## Setup (PowerShell)

### 1. Open up your git profile

`Notepad $profile`

### 2. Paste the following function into your profile

``` PowerShell
function git-pr()
{
    & c:\PATH-TO-GIT-PR\git-pr.ps1
}
```

### 3. Reload powershell console or run the following

`. $profile`
