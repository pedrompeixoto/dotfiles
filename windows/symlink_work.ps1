$dotfilesFolder= "$env:USERPROFILE\dotfiles"

New-Item -ItemType SymbolicLink -Force -Path $env:LOCALAPPDATA\nvim -Target $dotfilesFolder\common\neovim

New-Item -ItemType SymbolicLink -Force -Path $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Target $dotfilesFolder\windows\powershell\profile_work.ps1

New-Item -ItemType SymbolicLink -Force -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target $dotfilesFolder\windows\windows_terminal\settings.json 
