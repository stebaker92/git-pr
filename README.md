# git-pr

Create PR's on GitHub with ease from the command line.

Currently GitHub and GitLab are supported


## Usage

Just run
`pr`
or `git pr`
from your shell (whilst in a git directory) to open your browser ready to create a pull request

## Setup

[git alias Setup (`git pr`)](#git-setup)

[PowerShell alias Setup (`pr`)](#powershell-setup)

## git setup

### Run the following to setup the `git pr` alias

```PowerShell
git config --global alias.pr '!f() { powershell "C:/PATH-TO-GIT-PR/git-pr.ps1" ; }; f'
```

## PowerShell setup

Do the following to setup the `pr` alias

### 1. Open up your git profile

`Notepad $profile`

### 2. Import the PowerShell module into your profile

``` PowerShell
Import-Module C:\path-to-module\git-pr\git-pr.psm1
```

### 3. Reload powershell console or run the following

`. $profile`

### Targetting other branches

If you're working from a branch other then master (i.e. using a `develop` branch or a feature branch), set the `pr.base` config as follows:

`git config git-pr.base develop` 

## git bash setup

> TODO
