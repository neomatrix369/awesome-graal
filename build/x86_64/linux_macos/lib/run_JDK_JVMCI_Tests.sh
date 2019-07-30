#!/bin/bash

set -e
set -u
set -o pipefail

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Running JDK/JVMCI tests"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

BASEDIR=$1
MX=$2
cd ${BASEDIR}/graal-jvmci-8/
if [[ "${RUN_TESTS}" = "false" ]]; then
   echo ">>>> Skipping unit tests, won't run them."
else
    echo ">>>> Running unit tests..."
    ${MX} --java-home ${JAVA_HOME} unittest
fi