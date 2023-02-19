#!/usr/bin/env bash
# user info
USER_EMAIL="45339608+fernandodealcantara@users.noreply.github.com"
USER_NAME="Fernando de Alcantara"
GIT_COMMIT_TEMPLATE="$HOME/.gitmessage.txt"
export USER_EMAIL
export USER_NAME
export GIT_COMMIT_TEMPLATE
# WSL win 10 gui app config vcxsrv
#DISPLAY="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)":0 # in WSL 2
#LIBGL_ALWAYS_INDIRECT=1
#export DISPLAY
#export LIBGL_ALWAYS_INDIRECT

HOMEWIN="$(wslpath "$(wslvar -s USERPROFILE)")"
DOCSWIN="$(wslpath "$(wslvar -l Personal)")"
export HOMEWIN
export DOCSWIN

# aliases
alias cpi="$HOMEWIN/win32yank.exe -i" # paste from clipboard
alias cpo="$HOMEWIN/win32yank.exe -o" # copy to clipboard
alias ls=exa
alias cat=batcat
alias vim=nvim
