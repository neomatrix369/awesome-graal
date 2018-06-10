#!/bin/bash
# Copyright (c) 2018 Julien Ponge
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e
set -u
set -o
set pipefail

IFS=$'\n\t'

BASEDIR=$(pwd)
OUTPUT_DIR=${BASEDIR}/jdk8-with-graal
echo ">>> Working in ${BASEDIR}"

if [[ -e "mx/.git" ]]; then
    echo ">>> mx already exists: using the current version"
else
    echo ">>> Getting mx: mx is a build tool created for managing the development of (primarily) Java code"
    git clone --depth=1 git@github.com:graalvm/mx.git
fi

MX=${BASEDIR}/mx/mx

if [[ -e "graal-jvmci-8/.git" ]]; then
    echo ">>> graal-jvmci-8 already exists: using the current version"
else
    echo ">>> Getting Graal JVMCI for JDK8"
    git clone --depth=1 git@github.com:graalvm/graal-jvmci-8.git
fi

echo ">>> Building a JDK8 with JVMCI..."
cd graal-jvmci-8/
echo ">>>> Letting 'mx' build execute and pass-thru, even if the build fails"
${MX} --java-home ${JAVA_HOME} build || true
export JAVA_HOME=$(${MX} --java-home ${JAVA_HOME} jdkhome)

JDK8_JVMCI_IMAGE=$(${MX} jdkhome)
export JAVA_HOME=${JDK8_JVMCI_IMAGE}
echo ">>> Using ${JDK8_JVMCI_IMAGE}"

echo ">>> Building Graal"
cd ${BASEDIR}
if [[ -e "graal/.git" ]]; then
    echo ">>> graal already exists: using the current version"
else
    git clone --depth=1 git@github.com:oracle/graal.git
fi
cd graal/compiler

export JVMCI_VERSION_CHECK='ignore'
echo "Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
${MX} build
${MX} makegraaljdk ${OUTPUT_DIR}

echo ""
echo ">>> All good, now pick your JDK from ${OUTPUT_DIR} :-)"
