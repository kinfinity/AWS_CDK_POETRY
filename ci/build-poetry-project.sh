#!/bin/bash

set -eu

USAGE="USAGE:
${0} <project dir>"

if [[ $# < 1 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi

PROJECT_DIR=$1

pushd ${PROJECT_DIR} > /dev/null
ROOT_MODULE_DIR=$(ls src)
PACKAGE_NAME=${ROOT_MODULE_DIR}

mkdir -p reports

poetry install
poetry run black --check .
poetry run isort --check .
poetry run mypy --junit-xml=reports/mypy-junit.xml .
poetry run pylint ${ROOT_MODULE_DIR}

if [[ -d tests ]]; then
    poetry run pytest --junitxml=reports/pytest-junit.xml
fi

popd > /dev/null
