#!/usr/bin/bash
## Install script for the dotfiles

## UPDATE AND UPGRADE
function upgrade() {
    echo -e "\e[32mUpdating and upgrading\e[0m"
    sudo apt update && sudo apt upgrade -y
}

# ADD REPOS
function addRepos() {
    echo -e "\e[32mAdding repos\e[0m"
}

# CLONE REPOS
function cloneRepos() {
    echo -e "\e[32mCloning repos\e[0m"
    # clone antidote if necessary
    [[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
    # clone asdf if necessary
    [[ -e ~/.asdf ]] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
}

# INSTALL USEFUL PACKAGES
function installPackages() {
    # echo "Installing packages" in green color
    echo -e "\e[32mInstalling packages\e[0m"

    # Apt packages
    sudo apt install -y \
        software-properties-common \
        make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
        curl git stow zsh bat zip unzip ripgrep fd-find fzf neovim tmux \
        default-jre default-jdk exa nala wslu
}
# INSTALL SOME TOOLS
#CLIPBOARD
function getClipboardTool() {
    echo -e "\e[32mGetting clipboard tool\e[0m"
    wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip -O /tmp/win32yank.zip
    unzip /tmp/win32yank.zip win32yank.exe -d "$HOMEWIN"
}

# DOCKER
function getDocker() {
    echo -e "\e[32mGetting docker\e[0m"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo docker run hello-world
}

# SYMLINK CONFIG FILES
function symLink() {
    echo -e "\e[32mSymlinking config files\e[0m"
    # Symlink dotfiles
    stow -v -d ~/.dotfiles/ -t ~ zsh
    stow -v -d ~/.dotfiles/ -t ~ fonts
    mkdir -p ~/.config/nvim # create nvim folder
    stow -v -d ~/.dotfiles/ -t ~/.config/nvim neovim
    stow -v -d ~/.dotfiles/ -t ~ git
    sudo stow -v -d ~/.dotfiles/wsl -t /etc wslconf # sudo is needed for wsl.conf
    stow -v -d ~/.dotfiles/wsl -t "$HOMEWIN" wslconfig
}

# SETUP
# GIT
function gitSetup() {
    echo -e "\e[32mSetting up git\e[0m"
    # Git config
    git config --global commit.template "$GIT_COMMIT_TEMPLATE"
    git config --global user.name "$USER_NAME"
    git config --global user.email "$USER_EMAIL"
}

# ZSH
function zshSetup() {
    echo -e "\e[32mSetting up zsh\e[0m"
    # give permission to zsh
    which zsh | sudo tee -a /etc/shells # add zsh to list of shells
    chsh -s $(which zsh) # change shell to zsh

    # source .zshrc
    source ~/.zshrc
}

# NODE
function nodeSetup() {
    echo -e "\e[32mSetting up node\e[0m"
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest

    npm install -g tldr
    npm install -g yarn
    npm install -g typescript
}

# PYTHON
function pythonSetup() {
    echo -e "\e[32mSetting up python\e[0m"
    asdf plugin-add python
    asdf install python latest
    asdf global python latest
}

# RUST
function rustSetup() {
    echo -e "\e[32mSetting up rust\e[0m"
    asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
    asdf install rust latest
    asdf global rust latest
}
