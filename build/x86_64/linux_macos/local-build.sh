#!/bin/bash

#
# Extended off the original script (see https://github.com/jponge/build-graal-jvm/blob/master/build.sh) from @jponge
#

set -e
set -u
set -o pipefail

IFS=$'\n\t'

BASEDIR=$(pwd)
RUN_TESTS=${RUN_TESTS:-""}
JDK_GRAAL_FOLDER_NAME=jdk8-with-graal
BUILD_ARTIFACTS_DIR=${BASEDIR}/${JDK_GRAAL_FOLDER_NAME}
GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES:-"/substratevm,/tools,sulong,/graal-nodejs,/fastr,truffleruby,graalpython"}
export JAVA_OPTS="$(echo ${DOCKER_JAVA_OPTS:-""} ${JAVA_OPTS})"
export FASTR_RELEASE=true
export LC_ALL=C

echo ">>> Working in ${BASEDIR}"

printParameters() {
    echo "******************* Parameters ******************"
    echo "BASEDIR=${BASEDIR}"
    echo ""
    echo "JDK_GRAAL_FOLDER_NAME=${JDK_GRAAL_FOLDER_NAME}"
    echo "BUILD_ARTIFACTS_DIR=${BUILD_ARTIFACTS_DIR}"    
    echo "GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES}"
    echo ""
    echo "RUN_TESTS=${RUN_TESTS}"
    echo "JAVA_OPTS=${JAVA_OPTS}"
    echo "FASTR_RELEASE=${FASTR_RELEASE}"
    echo "LC_ALL=${LC_ALL}"        
    echo "*************************************************"
}

versionCheck() {
    program=${1}
    versionArg=${2:-"-version"}
    echo ""
    echo "${program} version check"
    ${program} ${versionArg}
}

displayDependencyVersion() {
    versionCheck java
    versionCheck make
    versionCheck python "--version"

    if [[ "$(uname)" = "Darwin" ]]; then
        echo ""
        echo "MacOS specific checks"
        versionCheck xcodebuild "--version" || true

        echo "LLVM:"
        versionCheck clang "--version"

        echo ""
        versionCheck openssl version
    fi

    echo ""
    echo "LLVM:"
    versionCheck opt "--version"
}

gitClone() {
    org=$1
    repo=$2
    programDesc=$3

    if [[ -e "${repo}/.git" ]]; then
        echo ">>> ${repo} already exists: updating and using this version"
        cd ${repo}
        git checkout .
        git pull
    else
        echo ">>> Getting ${repo}: ${programDesc}"
        git clone --depth=1 https://github.com/${org}/${repo}.git
    fi
}

setupMX() {
    cd ${BASEDIR}
    repo=mx
    gitClone graalvm \
             ${repo} \
             "${repo} is a build tool created for managing the development of (primarily) Java code"
    export MX=${BASEDIR}/${repo}/mx
}

build_JDK_JVMCI() {
    cd ${BASEDIR}
    gitClone graalvm       \
             graal-jvmci-8 \
             "Getting Graal JVMCI for JDK8"
             
    echo ">>> Building a JDK8 with JVMCI..."
    cd ${BASEDIR}/graal-jvmci-8/
    ${MX} --java-home ${JAVA_HOME} build
}

run_JDK_JVMCI_Tests() {
    cd ${BASEDIR}/graal-jvmci-8/
    if [[ "${RUN_TESTS}" = "false" ]]; then
       echo ">>>> Skipping unit tests, won't run them."
    else
        echo ">>>> Running unit tests..."
        ${MX} --java-home ${JAVA_HOME} unittest
    fi
}

setupEnvVariables() {
    export JDK8_JVMCI_IMAGE=$(${MX} --java-home ${JAVA_HOME} jdkhome)
    export JAVA_HOME=${JDK8_JVMCI_IMAGE}
    echo ">>> Using ${JDK8_JVMCI_IMAGE}"
}

buildGraalCompiler() {
    echo ">>> Building Graal"
    cd ${BASEDIR}
    gitClone oracle \
             graal  \
             "Getting sources for the Graal compiler"

    cd ${BASEDIR}/graal/compiler
    export JVMCI_VERSION_CHECK='ignore'
    echo ">>>> Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
    ${MX} build
    ${MX} makegraaljdk --force ${BUILD_ARTIFACTS_DIR}
}

applyPatches() {
    echo "Applying temporary patch to fix graaljs cloning issue in 'mx.vm/suite.py'"
    if [[ "$(uname)" = "Darwin" ]]; then
       sed -i '' 's/https:\/\/github.com\/oracle\/js.git/https:\/\/github.com\/graalvm\/graaljs.git/g' mx.vm/suite.py
    else
       sed -i 's https://github.com/oracle/js.git https://github.com/graalvm/graaljs.git ' mx.vm/suite.py
    fi

    echo "Applying temporary patch to fix graalpython cloning issue in 'mx.vm/suite.py'"
    if [[ "$(uname)" = "Darwin" ]]; then
        sed -i '' 's/https:\/\/github.com\/oracle\/graalpython.git/https:\/\/github.com\/graalvm\/graalpython.git/g' mx.vm/suite.py
    else
        sed -i 's https://github.com/oracle/graalpython.git https://github.com/graalvm/graalpython.git ' mx.vm/suite.py
    fi

    echo "Applying temporary patch to fix isValidJavaVersion() in https://github.com/oracle/graal/blob/master/substratevm/src/com.oracle.svm.hosted/src/com/oracle/svm/hosted/NativeImageGeneratorRunner.java#L156"    
    cp ${BASEDIR}/patch/NativeImageGeneratorRunner.java ${BASEDIR}/graal/substratevm/src/com.oracle.svm.hosted/src/com/oracle/svm/hosted/NativeImageGeneratorRunner.java    
}

buildGraalVMSuite() {
    echo ">>> Building GraalVM Suite"

    cd ${BASEDIR}/graal/vm
    applyPatches

    ${MX} --dy ${GRAALVM_SUITE_RUNTIMES} build
}

archivingArtifacts() {
    echo ""
    echo ">>> Creating Archive and SHA of the newly JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"
    cd ${BASEDIR}
    outputArchiveFilename=${JDK_GRAAL_FOLDER_NAME}.tar.gz
    shaSumFilename=${outputArchiveFilename}.sha256sum.txt
    echo ">>>> Creating Archive ${outputArchiveFilename}"
    GZIP=-9 tar -czf ${outputArchiveFilename} "${JDK_GRAAL_FOLDER_NAME}"

    echo ">>>> Creating a sha5 hash from ${outputArchiveFilename}"
    shasum ${outputArchiveFilename} > ${shaSumFilename}

    OUTPUT_DIR=${OUTPUT_DIR:-""}
    if [[ ! -e "${OUTPUT_DIR}" ]]; then
        echo ">>>> Output directory not set or found"
        OUTPUT_DIR="${BASEDIR}/jdk8-with-graal-local"
        mkdir -p ${OUTPUT_DIR}
        echo ">>>> Output directory ${OUTPUT_DIR} created"
    fi

    mv ${outputArchiveFilename} ${OUTPUT_DIR}
    mv ${shaSumFilename} ${OUTPUT_DIR}
    echo ">>> ${outputArchiveFilename} and ${shaSumFilename} have been successfully created in the ${OUTPUT_DIR} folder."
}

run() {
    printParameters
    displayDependencyVersion
    time setupMX
    time build_JDK_JVMCI
    time run_JDK_JVMCI_Tests
    setupEnvVariables
    time buildGraalCompiler
    time buildGraalVMSuite
    time archivingArtifacts
}

time run
