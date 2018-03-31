# git-pr

Create PR's on GitHub with ease from the command line.

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

## powershell setup

Do the following to setup the `pr` alias

### 1. Open up your git profile

`Notepad $profile`

### 2. Paste the following function into your profile

``` PowerShell
function pr() # Replace pr this with any alias you want to use
{
    & c:\PATH-TO-GIT-PR\git-pr.ps1
}
```

### 3. Reload powershell console or run the following

`. $profile`

## git bash setup

> TODO
