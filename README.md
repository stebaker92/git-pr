# git-pr

Create Pull Requests with ease from the command line.

Currently only GitHub, GitLab and Azure DevOps are supported

## Usage & Functions

### Pull Requests

Just run
`pr`
or `git pr`
from your shell (whilst in a git directory) to open your browser ready to create a pull request, setting the source to the current branch and target to either `master` or the branch stored in the repo's git config

### Opening the current repo in your browser

Just run `git-repo` to open the remote repository in your browser

### Searching GitHub

`github-search MySearchTerm`

## PowerShell Alias Setup

Do the following to setup the `pr` alias (you'll currently need to clone this repo)

### 1. Open up your PowerShell profile

`Notepad $profile`

### 2. Import the PowerShell module into your profile

``` PowerShell
Import-Module C:\path-to-module\git-pr\git-pr.psm1
```

### 3. Reload powershell console or run the following

`. $PROFILE` or `RefreshEnv`
If this doesn't work, you may need to restart your shell

### Setting the Target Branch

By default, the target branch will be `master` if you don't specify one. If you want to change & save a different target branch (i.e.  if you're working of a `develop` branch or a feature branch), set the `pr.base` config by running `git config git-pr.base my-branch
` or changing your your repo's `.gitconfig` to the following:

`pr-base my-branch` 

## Running Unit Tests
run `Invoke-Pester .\all-tests.ps1`

You will need to install [Pester](https://github.com/pester/Pester#installation) for running unit tests