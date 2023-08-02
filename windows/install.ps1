# Install packages
Write-Output "Installing packages..."

# Dev tools
winget install Microsoft.WindowsTerminal
winget install Microsoft.VisualStudioCode
winget install Neovim.Neovim
winget install Microsoft.PowerShell
winget install Microsoft.Powertoys  
winget install DevToys
winget install Git.Git
winget install GitHub.GitHubDesktop
winget install dbeaver.dbeaver
winget install Insomnia.Insomnia
# General apps
winget install Mozilla.Firefox
winget install "Microsoft Whiteboard"
# Utilities
winget install Bitwarden.Bitwarden # Password manager
winget install 7zip.7zip  # File archiver 
winget install File-New-Project.EarTrumpet # Volume control
winget install qBittorrent.qBittorrent # Torrent client
winget install Skillbrains.Lightshot # Screenshot tool
winget install JackieLiu.NotepadsApp # Notepad replacement
winget install VideoLAN.VLC # Video player
winget install OBSProject.OBSStudio # Screen recorder
winget install KDE.Okular # PDF reader
winget install JAMSoftware.TreeSize.Free # Disk usage analyzer
winget install Microsoft.DirectX # DirectX
winget install JanDeDobbeleer.OhMyPosh -s winget # Install Oh My Posh

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Get win32yank (cli clipboard) tool)
Invoke-WebRequest -Uri 'https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip' -OutFile "$env:TEMP\win32yank.zip"
Expand-Archive -Path "$env:TEMP\win32yank.zip" -DestinationPath $HOME


# Install powershell modules
# posh git
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force # Install posh-git
# z-location
PowerShellGet\Install-Module ZLocation -Scope CurrentUser -Force # Install z-location

# Create folders
# create repositories folder
Write-Output "Creating folders..."
$repositoriesPath = "D:\repositories"
if (!(Test-Path $repositoriesPath)) {
  Write-Output "Creating folder: $repositoriesPath"
  New-Item -ItemType Directory -Path $repositoriesPath -Force
}

# Symlinking
Write-Output "Symlinking..."
# symlink powershell .dotfiles profile if doesn't exist
$symLinkPath = "$env:USERPROFILE\Documents\Powershell\Microsoft.PowerShell_profile.ps1"
$fileToLink = "$PWD\Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force


# symlink gitconfig .dotfiles config if doesn't exist
$symLinkPath = "$HOME\.gitconfig"
$fileToLink = "$PWD\..\shared\git\.gitconfig"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force


# symlink gitmessage .dotfiles config if doesn't exist
$symLinkPath = "$HOME\.gitmessage.txt"
$fileToLink = "$PWD\..\shared\git\.gitmessage.txt"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force


# symlink neovim .dotfiles config if doesn't exist
$symLinkPath = "$env:LOCALAPPDATA\nvim\init.vim"
$fileToLink = "$PWD\..\shared\neovim\init.vim"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force


# symlink .wslconfig if doesn't exist
$symLinkPath = "$HOME\.wslconfig"
$fileToLink = "$PWD\.wslconfig"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force


# symlink windows terminal settings if doesn't exist
$symLinkPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$fileToLink = "$PWD\windows-terminal-settings.json"
New-Item -ItemType SymbolicLink -Path $symLinkPath -Target $fileToLink -Force

# Install WSL
Write-Output "WSL installation..."
wsl --install -d Ubuntu-22.04
