#!/usr/bin/env bash

set -e
set -u
set -o pipefail

versionCheck() {
    program=${1}
    versionArg=${2:-"-version"}
    echo ""
    echo "${program} version check"
    ${program} ${versionArg}
}

gitClone() {
    org=$1
    repo=$2
    branch=${3:-master}
    programDesc=$4
    cloneType=${5:-"shallow"}

    if [[ -e "${repo}/.git" ]]; then
        echo ">>> ${repo} already exists: updating and using this version"
        cd ${repo}
        git checkout .
        if [[ "${cloneType}" = "deep" ]]; then
           git fetch
           git pull || true
        fi
    else
        echo ">>> Getting ${repo}: ${programDesc}"
        if [[ "${cloneType}" = "deep" ]]; then
           echo ">>> Cloning deep: includes commits & tags data"
           set -x
           git clone -b ${branch} https://github.com/${org}/${repo}.git
           set +x
        else
           echo ">>> Cloning shallow: excludes commits & tags data"
           set -x
           git clone --depth=1 -b ${branch} https://github.com/${org}/${repo}.git
           set +x
        fi
    fi
}

getAvailableThreads() {
    if [[ -f "/.dockerenv" ]]; then
       result=$(cat /sys/fs/cgroup/cpuset/cpuset.cpus | awk -F'-' '{print $2}')
       result=$((result + 1))
    else
        if [[ "$(uname)" = "Darwin" ]]; then
            result=$(sysctl -n hw.ncpu || true)
        else
            result=$(nproc --all || true)
        fi
    fi
    echo ${result:-4}
}

getAllowedThreads() {
    availableThreads=$(getAvailableThreads)
    thresholdLimit="$(awk "BEGIN {print (${availableThreads} * 1/2)}")"
    if [[ -z "${availableThreads}" ]] || [[  "${availableThreads}" -ge "${thresholdLimit}" ]]; then
        availableThreads="${thresholdLimit}"
    fi
    echo ${availableThreads}
}

getHWInfo() {
    if [[ "$(uname)" = "Darwin" ]]; then
       system_profiler SPHardwareDataType || true
    else
       lscpu || true
    fi
}

getVMInfo() {
    if [[ "$(uname)" = "Darwin" ]]; then
        result=$(ioreg -l | grep -e Manufacturer -e 'Vendor Name')
    else
        result=$(cat /proc/cpuinfo | grep hypervisor || true)
    fi

    echo ${result}
}

getMemoryInfo() {
    if [[ "$(uname)" = "Darwin" ]]; then
        top -l 1 -s 0 | grep PhysMem
        sysctl vm.swapusage
    else
        free -m
        free -m -h
    fi
}

getOSInfo() {
    if [[ "$(uname)" = "Darwin" ]]; then
        system_profiler SPSoftwareDataType || true
    else
        cat /etc/lsb-release || true
    fi
}
