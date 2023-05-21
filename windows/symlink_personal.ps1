$dotfilesFolder= $env:USERPROFILE + "\dotfiles"

$programs = @(
    [pscustomobject]@{
        name = "neovim"
        source_path = $dotfilesFolder + "\configs\nvim"
        target_path = $env:LOCALAPPDATA + "\nvim"
    }
    [pscustomobject]@{
        name = "windows terminal"
        source_path = $dotfilesFolder + "\windows\windows_terminal\settings.json"
        target_path = $env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    }
    [pscustomobject]@{
        name = "git config"
        source_path = $dotfilesFolder + "\configs\git\gitconfig"
        target_path = $env:USERPROFILE + "\.gitconfig"
    }
)

foreach ($program in $programs) {
    New-Item -ItemType SymbolicLink -Force -Path $program.target_path -Target $program.source_path
    Write-Host "Symlinked " + $program.name
}
