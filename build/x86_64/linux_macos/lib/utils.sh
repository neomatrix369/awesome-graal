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
    programDesc=$3
    tag=${4:-master}

    if [[ -e "${repo}/.git" ]]; then
        echo ">>> ${repo} already exists: updating and using this version"
        cd ${repo}
        git checkout .
        git pull
    else
        echo ">>> Getting ${repo}: ${programDesc}"
        git clone https://github.com/${org}/${repo}.git
    fi
    git checkout ${tag}
}