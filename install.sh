#!/usr/bin/bash

source ./functions.sh

addRepos
upgrade
installPackages
cloneRepos

source ./custom.sh

getClipboardTool
getDocker

symLink

gitSetup
zshSetup

nodeSetup
