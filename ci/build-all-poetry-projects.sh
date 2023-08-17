#!/bin/bash

set -eu

USAGE="Searches PWD for any pyproject.toml, tests and builds them

USAGE:
${0}"

if [[ $# > 1 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi

THIS_DIR=$(dirname ${BASH_SOURCE[0]})

for PROJECT_FILE in $(find . -name pyproject.toml); do
    echo Building from ${PROJECT_FILE}
    ${THIS_DIR}/build-poetry-project.sh $(dirname ${PROJECT_FILE})
done
