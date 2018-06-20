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
echo ">>> Working in ${BASEDIR}"

displayDependencyVersion() {
    echo ""
    echo "java version check"
    java -version

    echo ""
    echo "make version check"
    make -version

    echo ""
    echo "python version check"
    python --version

    if [[ "$(uname)" = "Darwin" ]]; then
        echo ""
        echo "MacOS specific checks"
        echo "xcode version check"
        xcodebuild -version || true
        
        echo ""
        echo "LLVM: clang version check"
        clang --version
    fi
    
    echo ""
    echo "LLVM: opt version check"
    opt --version
}

setupMX() {
    cd ${BASEDIR}
    if [[ -e "mx/.git" ]]; then
        echo ">>> mx already exists: updating and using this version"
        cd mx
        git checkout .
        git pull
    else
        echo ">>> Getting mx: mx is a build tool created for managing the development of (primarily) Java code"
        git clone --depth=1 https://github.com/graalvm/mx.git
    fi
    export MX=${BASEDIR}/mx/mx
}

build_JDK_JVMCI() {
    cd ${BASEDIR}
    if [[ -e "graal-jvmci-8/.git" ]]; then
        echo ">>> graal-jvmci-8 already exists: updating and using this version"
        cd graal-jvmci-8
        git checkout .
        git pull
    else
        echo ">>> Getting Graal JVMCI for JDK8"
        git clone --depth=1 https://github.com/graalvm/graal-jvmci-8.git
    fi
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
    if [[ -e "graal/.git" ]]; then
        echo ">>> graal already exists: updating and using this version"
        cd graal
        git checkout .
        git pull
    else
        git clone --depth=1 https://github.com/oracle/graal.git
    fi
    cd ${BASEDIR}/graal/compiler
    export JVMCI_VERSION_CHECK='ignore'
    echo ">>>> Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
    ${MX} build
    ${MX} makegraaljdk --force ${BUILD_ARTIFACTS_DIR}
}

buildGraalVMSuite() {
    echo ">>> Building GraalVM Suite"
    cd ${BASEDIR}/graal/vm
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

    export FASTR_RELEASE=true
    FASTR_RELEASE=true ${MX} --dy /substratevm,/tools,sulong,/graal-nodejs,/fastr,truffleruby,graalpython build
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
