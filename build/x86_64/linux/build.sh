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
set -euo pipefail
IFS=$'\n\t'

BASEDIR=$(pwd)
OUTPUT_DIR=${BASEDIR}/jdk8-with-graal
echo ">>> Working in ${BASEDIR}"

echo ">>> Getting mx..."
git clone --depth=1 git@github.com:graalvm/mx.git
MX=${BASEDIR}/mx/mx

echo ">>> Building a JDK8 with JVMCI..."
git clone --depth=1 git@github.com:graalvm/graal-jvmci-8.git
cd graal-jvmci-8/
${MX} build
JDK8_JVMCI_IMAGE=$(mx jdkhome)
export JAVA_HOME=${JDK8_JVMCI_IMAGE}
echo ">>> Using ${JDK8_JVMCI_IMAGE}"

echo ">>> Building Graal"
cd ${BASEDIR}
git clone --depth=1 git@github.com:oracle/graal.git
cd graal/compiler
export JVMCI_VERSION_CHECK='ignore'
${MX} build
${MX} makegraaljdk ${OUTPUT_DIR}

echo "\n>>> All good, now pick your JDK in ${OUTPUT_DIR} :-)"