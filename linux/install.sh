#!/usr/bin/bash


# ADD REPOS
echo -e "\e[32mAdding repos\e[0m"


# UPDATE AND UPGRADE
echo -e "\e[32mUpdating and upgrading\e[0m"
sudo apt update && sudo apt upgrade -y


# CLONE REPOS
echo -e "\e[32mCloning repos\e[0m"
# clone antidote if necessary
[[ -e ~/.antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
# clone asdf if necessary
[[ -e ~/.asdf ]] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1


# INSTALL PACKAGES
echo -e "\e[32mInstalling packages\e[0m"
sudo apt install -y \
    software-properties-common \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    curl git stow zsh bat zip unzip ripgrep fd-find fzf neovim tmux \
    default-jre default-jdk exa nala wslu


# get docker if not installed
if ! command -v docker &> /dev/null
then
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
fi


# LOAD ALIASES, FUNCTIONS, AND ENVIRONMENT VARIABLES
source ./myenv.sh


# SSH
echo -e "\e[32mSetting up ssh\e[0m"
if [ ! -e ~/.ssh/id_ed25519.pub ]
then
    ssh-keygen -t ed25519 -C $USER_EMAIL
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi


# Symlink dotfiles
echo -e "\e[32mSymlinking config files\e[0m"
# shared
stow -v -d ../shared -t ~ fonts
stow -v -d ../shared -t ~ git
mkdir -p ~/.config/nvim # create nvim folder
stow -v -d ../shared -t ~/.config/nvim neovim
# linux
stow -v -d ./ -t ~ zsh
# symlink myenv.sh file to ~
echo -e "\e[32mSymlinking myenv.sh to ~/.myenv.sh\e[0m"
ln -s $PWD/myenv.sh ~/.myenv.sh
# symlink wsl.conf file to /etc
echo -e "\e[32mSymlinking wsl.conf to /etc/wsl.conf\e[0m"
sudo ln -s $PWD/wsl.conf /etc/wsl.conf


# ZSH
echo -e "\e[32mSetting up zsh\e[0m"
# give permission to zsh
# add zsh to list of shells if not in list
grep -qxF "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh) # change shell to zsh


# ASDF SETUPS
source ~/.asdf/asdf.sh # load asdf
