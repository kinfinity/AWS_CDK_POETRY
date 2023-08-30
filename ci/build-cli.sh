#!/bin/bash

set -eu

USAGE="USAGE:
${0} <release-version>"

if [[ $# -ne 1 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi
  
# Define the exit trap function
cleanup() {
    echo "Cleaning up before exit..."
    find . -type f -name ./bin/${ARCH_AMD64}-${GOOS_W}-aws_cdk_poetry-${RELEASE_VERSION} -delete
    find . -type f -name ./bin/${ARCH_AMD64}-${GOOS_L}-aws_cdk_poetry-${RELEASE_VERSION} -delete
    find . -type f -name ./bin/${ARCH_AMD64}-${GOOS_D}-aws_cdk_poetry-${RELEASE_VERSION} -delete
}
# trap cleanup EXIT

pushd ${PWD} > /dev/null

RELEASE_VERSION=$1

# GOOS — Operating system for which we want to build
# GOARCH — The architecture of the OS for which we want to build
ARCH_AMD64="amd64"
GOOS_L="linux"
GOOS_W="windows"
GOOS_D="darwin"

go get -u golang.org/x/lint/golint
go vet .
# golint .

! [ -d bin ] && mkdir bin
# 
echo "Building binary for Windows..."
! [ -f ./bin/${ARCH_AMD64}-${GOOS_W}-aws_cdk_poetry-${RELEASE_VERSION} ] && env GOOS=${GOOS_W} GOARCH=${ARCH_AMD64} go build -o ./bin/${ARCH_AMD64}-${GOOS_W}-aws_cdk_poetry-${RELEASE_VERSION}

# 
echo "Building binary for Linux..."
! [ -f ./bin/${ARCH_AMD64}-${GOOS_L}-aws_cdk_poetry-${RELEASE_VERSION} ] && env GOOS=${GOOS_L} GOARCH=${ARCH_AMD64} go build -o ./bin/${ARCH_AMD64}-${GOOS_L}-aws_cdk_poetry-${RELEASE_VERSION}

# 
echo "Building binary for Darwin..."
! [ -f ./bin/${ARCH_AMD64}-${GOOS_D}-aws_cdk_poetry-${RELEASE_VERSION} ] && env GOOS=${GOOS_D} GOARCH=${ARCH_AMD64} go build -o ./bin/${ARCH_AMD64}-${GOOS_D}-aws_cdk_poetry-${RELEASE_VERSION}

# Check files
[ -d ./bin ] && ls ./bin -l

# RUN cmd
# ./aws_cdk_poetry generate --name cdktest --platform Linux|Darwin|Windows

popd > /dev/null
