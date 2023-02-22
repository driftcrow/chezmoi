# install choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# install scoop
#Set-ExecutionPolicy RemoteSigned -scope CurrentUser
#Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
# iwr -useb get.scoop.sh | iex
if (-not (Get-Command scoop -errorAction SilentlyContinue)) {
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}

# iwr -useb https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1 | iex
# scoop config SCOOP_REPO 'https://gitee.com/glsnames/Scoop-Core'
# scoop update
scoop install git

# install chezmoi
#(irm -useb https://get.chezmoi.io/ps1) | powershell -c -
scoop install chezmoi

scoop install aria2
# aria2 在 Scoop 中默认开启
# scoop config aria2-enabled true
scoop config aria2-warning-enabled false
scoop config aria2-retry-wait 4
scoop config aria2-split 16
scoop config aria2-max-connection-per-server 16
scoop config aria2-min-split-size 4M

$script_dir= Get-Location
Set-Alias cm "chezmoi.exe --source=$script_dir"
#chezmoi init --apply "--source=$script_dir"
chezmoi init "--source=$script_dir"
