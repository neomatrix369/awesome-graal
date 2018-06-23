#!/bin/bash

set -e
set -u
set -o pipefail

setupEnvVariables() {
    MX=$1
    export JDK8_JVMCI_IMAGE=$(${MX} --java-home ${JAVA_HOME} jdkhome)
    export JAVA_HOME=${JDK8_JVMCI_IMAGE}
    echo ">>> Using ${JDK8_JVMCI_IMAGE}"
}
