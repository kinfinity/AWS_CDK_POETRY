#!/bin/bash

set -eu
# xpv

USAGE="USAGE:
${0} <project name>[string] <setup-requirements>[yes]"

[[ $# < 1 ]]  && echo "${USAGE}" >&2 && exit 1

PROJECT_NAME=$1
SETUP_REQUIREMENTS=$2

# Get absolute path of script dir
DIR="$( dirname -- "${BASH_SOURCE[0]}"; )"
pushd ${DIR} > /dev/null

# check & execute setup script
SCRIPT_PATH="./setup_requirements.sh"
sudo chmod +x $SCRIPT_PATH
[ ! -z "$SETUP_REQUIREMENTS" ] && [ "$SETUP_REQUIREMENTS" == 'yes' ] && $SCRIPT_PATH

setup_dir() {
    [ ! -d CDK_PROJECTS ] && mkdir CDK_PROJECTS 
    pushd CDK_PROJECTS
    [ ! -d $1 ] && mkdir $1 && pushd $1 && cdk init app --language python

    mkdir -p src/$1
    find . -maxdepth 1 -type f -name app.py -exec mv {} src/$1 \;
    find . -maxdepth 1 -type d -name $1 -exec mv {} src/$1 \;
    find . -maxdepth 1 -type d -name tests -exec mv {} src/$1 \;

    trap cleanup_temp RETURN
} # we do not overwrite the directory if it already exists

cleanup_dir(){
    find . -type d -name $1 -exec rm -rf {} +
}

cleanup_file(){
    find . -type f -name $1 -delete
}

cleanup_temp(){
    echo "Cleaning up directory ..."
    cleanup_dir ".venv"
    cleanup_file "requirements-dev.txt"
    cleanup_file "source.bat"
    cleanup_file "README.md"
    popd
    popd # get back to base on dir stack
    [ -f poetry_cdk.readme.md ] && cp poetry_cdk.readme.md  CDK_PROJECTS/$PROJECT_NAME/README.md
}

integrate_poetry(){
    pushd CDK_PROJECTS/$1
    [ ! -f pyproject.toml ] && poetry init -n
    popd
}

initialize_poetry(){
    # sed replace & create poetry module & scripts
    sed "s/PROJECT_MODULE/${PROJECT_NAME}/g" ./configs/pyproject.toml.template > ./extras.toml.template
    _dangle=`cat extras.toml.template`
    [ -f ./extras.toml.template ] && cleanup_file extras.toml.template

    pushd CDK_PROJECTS/$1
    # patch poetry toml 
    awk -v dangle="$_dangle" 'NR == 7 { print dangle } 1' ./pyproject.toml > temp.toml && mv temp.toml ./pyproject.toml

    # install 
    [ -f ./requirements.txt ] && poetry add $( cat requirements.txt )
    # dependencies to help
    poetry add black --group dev
    poetry add mypy --group dev
    poetry add pylint --group dev
    #  cleanup
    cleanup_file "requirements.txt"
    # poetry export --without-hashes --format=requirements.txt > requirements.txt
    poetry check
    poetry install
    popd
}

update_cdk_poetry(){
    pushd CDK_PROJECTS/$1
    invoke_app=$(echo "\"app\": \"poetry run python3 src/${1}/app.py\",")
    # patch cdk file for poetry 
    awk -v invoke_app="$invoke_app" 'NR == 2 { print invoke_app; next } 1' ./cdk.json > cdk.json.temp && mv cdk.json.temp ./cdk.json
    popd
}

echo "Setting up directory ..." && setup_dir $PROJECT_NAME 
echo "Integrating poetry ..." && integrate_poetry $PROJECT_NAME && initialize_poetry $PROJECT_NAME
echo "Patch cdk file with poetry ..." && update_cdk_poetry $PROJECT_NAME
