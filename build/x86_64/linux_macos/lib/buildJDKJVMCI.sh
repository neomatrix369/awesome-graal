#!/usr/bin/env bash

set -e
set -u
set -o pipefail

build_JDK_JVMCI() {
    BASEDIR=$1
    MX=$2
    cd ${BASEDIR}
    gitClone graalvm       \
             graal-jvmci-8 \
             "Getting Graal JVMCI for JDK8"

    echo ">>> Building a JDK8 with JVMCI..."
    cd ${BASEDIR}/graal-jvmci-8/
    ${MX} --java-home ${JAVA_HOME} build
}
