#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

printHWInfo() {
    echo ""
    echo "Display hardware information"
    lscpu
    echo ""
    free -m
    free -m -h
}

printRuntimeEnvInfo() {
    dockerContainer=""
    if [[ -f "/.dockerenv" ]]; then
        dockerContainer="inside a docker container "
    fi

    runningInsideA_VM="$(cat /proc/cpuinfo | grep hypervisor || true)"
    if [[ -z "${runningInsideA_VM}" ]]; then
        machine="bare-metal (native)"
    else
        machine="VM or VM-like"
    fi

    echo ""
    echo ">>> Processes are running ${dockerContainer}on a ${machine} environment <<<"
}

printOSInfo() {
    echo ""
    echo "Display OS information"
    uname -a

    printRuntimeEnvInfo
}

printHWInfo
printOSInfo

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
