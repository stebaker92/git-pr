# git-pr

Create Pull Requests with ease from the command line.

Currently only GitHub and GitLab are supported


## Usage & Functions

### Pull Requests

Just run
`pr`
or `git pr`
from your shell (whilst in a git directory) to open your browser ready to create a pull request

### Opening Repo in browser

Just run `git-repo` to open the remote repository in your browser

### Searching GitHub

`github-search MySearchTerm`

## PowerShell alias setup

Do the following to setup the `pr` alias (you'll currently need to clone this repo)

### 1. Open up your git profile

`Notepad $profile`

### 2. Import the PowerShell module into your profile

``` PowerShell
Import-Module C:\path-to-module\git-pr\git-pr.psm1
```

### 3. Reload powershell console or run the following

`. $profile` or `RefreshEnv`

### Setting the Target Branch

If you're working from a branch other then master (i.e. using a `develop` branch or a feature branch), set the `pr.base` config as follows:

`pr-base develop` 
