#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1
MX=$2
GRAALVM_SUITE_RUNTIMES=$3

echo ">>> Building GraalVM Suite"

./applyPatches.sh ${BASEDIR}

cd ${BASEDIR}/graal/vm
${MX} --dy ${GRAALVM_SUITE_RUNTIMES} build