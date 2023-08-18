$nvim = 'C:\Program Files\Neovim\bin;'
$zip = 'C:\Program Files\7-Zip;'
$fd = $env:USERPROFILE + '\programs\fd;';
$rg = $env:LOCALAPPDATA + '\Microsoft\WinGet\Packages\BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe\ripgrep-13.0.0-x86_64-pc-windows-msvc;';

$env:Path = $nvim + $zip + $fd + $rg + $env:Path

pushd "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"
cmd /c "vcvars64.bat&set" |
foreach {
  if ($_ -match "=") {
    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
  }
}
popd
Write-Host "`nVisual Studio 2022 Command Prompt variables set." -ForegroundColor Yellow

$PSStyle.FileInfo.Directory = ""
