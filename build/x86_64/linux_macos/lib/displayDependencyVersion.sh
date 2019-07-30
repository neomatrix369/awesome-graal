#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

printHWInfo() {
    echo ""
    echo "Display hardware information"
    getHWInfo

    echo ""
    getMemoryInfo

    echo ""
    echo "Available threads (from all online CPUs/Cores): $(getAvailableThreads)"
}

printRuntimeEnvInfo() {
    dockerContainer=""
    if [[ -f "/.dockerenv" ]]; then
        dockerContainer="inside a docker container "
    fi

    if [[ -z "$(getVMInfo)" ]]; then
        machine="bare-metal (native)"
    else
        machine="VM or VM-like"
    fi

    echo ""
    echo "*******************************************************************************"
    echo "* Processes are running ${dockerContainer}on a ${machine} environment"
    echo "*******************************************************************************"
}

printOSInfo() {
    echo ""
    echo "Display OS information"
    uname -a

    echo ""
    getOSInfo
}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Display Dependency versions"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

printHWInfo
printOSInfo
printRuntimeEnvInfo

versionCheck gcc "--version"
versionCheck g++ "--version"
versionCheck java
versionCheck make
versionCheck python "--version"

if [[ "$(uname)" = "Darwin" ]]; then
    echo ""
    echo "MacOS specific checks"
    versionCheck xcodebuild "--version" || true
fi

echo ""
echo "LLVM:"
versionCheck opt "--version"
versionCheck clang "--version"

echo ""
versionCheck openssl version
