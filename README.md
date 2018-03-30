# git-pr

Create PR's on GitHub with ease from the command line. Just run
`pr` 
or `git pr`
from your shell (whilst in a git directory) to open your browser ready to create a pull request

## Setup PowerShell alias (through PowerShell profile)

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

## Setup PowerShell alias (through PowerShell command line)

### 1. Create the function by running the following command

``` PowerShell
function git-pr()
{
    & c:\PATH-TO-GIT-PR\git-pr.ps1
}
```

### 2. Set an alias for the above function

`Set-Alias -Name pr -Value git-pr`

## Setup git alias

### 1. Open your .gitconfig

`C:\users\awesomegituser\.gitconfig`

### 2. Add the following to your alias section

``` gitconfig
[alias]
pr = "!f() { powershell "C:/PATH-TO-GIT-PR/git-pr.ps1" ; }; f"
```

## Setup git alias (via command line)

### 1. Run the following to setup the alias

```PowerShell
git config --global alias.pr '!f() { powershell "D:/projects/git-pr/git-pr.ps1" ; }; f'
```