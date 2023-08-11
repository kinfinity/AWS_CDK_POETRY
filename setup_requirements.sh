#!/bin/bash

set -eu

USAGE="USAGE:
${0}"

[[ $# -ne 0 ]] && echo "${USAGE}" >&2 && exit 1

# check requirements
check_req(){
    command=$($1 --version)
    echo $command
    if [[ $? != 0 ]];then # $? contains exit code of the last command
        echo "ERROR: ${1} is not installed."
    fi
}

# install requirements
## install python3
install_python() {
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get update && sudo apt upgrade --yes
    sudo apt-get install python3 --yes
    python3 --version
}
## install poetry
install_poetry () {
    curl -sSL https://install.python-poetry.org | python3 -
    poetry --version
}
## install nodejs
install_nodejs (){
    sudo apt update && sudo apt upgrade --yes
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install latest
    node --version && npm --version 
}
## install awscdk 
install_awscdk(){
    npm install -g aws-cdk
}

# 
check_req python3 && install_python
check_req poetry && install_poetry
check_req node && install_nodejs && install_awscdk
