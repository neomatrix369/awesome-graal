#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

printHWInfo() {
    echo ""
    echo "Display hardware information"
    if [[ "$(uname)" = "Darwin" ]]; then
       system_profiler SPHardwareDataType
    else
       lscpu
    fi

    echo ""
    if [[ "$(uname)" = "Darwin" ]]; then
        top -l 1 -s 0 | grep PhysMem
        sysctl vm.swapusage
    else
        free -m
        free -m -h
    fi

    echo ""
    echo "Available threads (from all CPUs/Cores): $(nproc --all)"
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
    echo "*******************************************************************************"
    echo "* Processes are running ${dockerContainer}on a ${machine} environment"
    echo "*******************************************************************************"
}

printOSInfo() {
    echo ""
    echo "Display OS information"
    uname -a

    echo ""
    cat /etc/lsb-release
}

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
