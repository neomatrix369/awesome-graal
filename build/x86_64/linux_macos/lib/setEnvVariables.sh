#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1
MX=$2
export JVMCI_VERSION_CHECK='ignore'
export JAVA_HOME="$(cd ${BASEDIR}/graal-jvmci-8/ && ${MX} --java-home ${JAVA_HOME} jdkhome)"
echo ">>>> Using JDK8_JVMCI_HOME as JAVA_HOME (${JAVA_HOME})"
