# Environment configuration

Basic configuration files for my personal setup (Windows 10, WSL, Ubuntu 22.04).

I try to let the script small and simple. I don't want to install a lot of apps and I don't want to configure a lot of things. I just want to install the apps I need and configure the things I need.

This script is divided into two parts:

Windows part which is responsible for installing Windows applications and configure some Windows settings.

Linux part which is responsible for installing Linux applications and configure some Linux settings (WSL).

## Windows part
```powershell
cd windows
.\install.ps1
```

Before running the script, you should make sure you can run scripts on your machine. To do that, run the following command in PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

`install.ps1` script will install apps using winget and chocolatey, symlink files, install fonts, configure Windows settings and install WSL (Ubuntu 22.04).

You should run `install.ps1` script as an administrator.

## Linux part
```bash
cd linux
# maybe you need to run `chmod +x install.sh` first
./install.sh
```

`install.sh` script will first add some repositories, update and upgrade the system, clone some repositories (antidote and asdf), install apps using apt, install docker, load myenv.sh (which contains my aliases, environment variables and functions), generate ssh keys, symlink files, config zsh, load .zshrc and install some asdf plugins.

You should run `install.sh` script as an administrator.

## Manual steps
- Install fonts located in shared/fonts/.fonts in Windows
- [ ] Configure myenv.sh (aliases, environment variables and functions) to your needs.
- [ ] Configure .gitconfig to your needs.
- [ ] Configure folders that will be created (`install.ps1` creates a repositories folder). For example, I have a folder called `D:\repositories` where I keep all my repositories. You can change it to `D:\projects` `C:\Users\<username>\projects` or whatever you want.
