#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1
JDK_GRAAL_FOLDER_NAME=$2

echo "Simple sanity checking of the JDK artifact"
cd ${BASEDIR}/${JDK_GRAAL_FOLDER_NAME}
ls -lash bin
set -x
./bin/java -version
./bin/javac -version
set +x

echo "Simple sanity checking of the JRE artifact"
cd ${BASEDIR}/${JDK_GRAAL_FOLDER_NAME}/jre
ls -lash bin
set -x
./bin/java -version
set +x