#!/bin/bash

set -e
set -u
set -o pipefail

export DEBUG=${DEBUG:-"false"}
export RUN_TESTS=${RUN_TESTS:-"true"}

export JAVA_VERSION=${JAVA_VERSION:-jdk8u152-b16}
export JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG:-"adoptopenjdk/openjdk8:${JAVA_VERSION}"}
export DOCKER_IMAGE_TAG="graal-jdk8:latest"
export USER_IN_CONTAINER=${USER_IN_CONTAINER:-"graal"}
export CONTAINER_HOME_DIR="/home/${USER_IN_CONTAINER}"
export MAKE_VERSION=${MAKE_VERSION:-4.2}
export DOCKER_MEMORY=4096M
export DOCKER_JAVA_OPTS="-Xms2g -Xmx2g -XX:MaxPermSize=1g -XX:+PrintFlagsFinal"

export HOST_REPOS_DIR=${HOST_REPOS_DIR:-""}
if [[ ! -z "${HOST_REPOS_DIR}" ]]; then
   export HOST_REPOS_DIR="$(pwd)/jdk8-with-graal-repos"
fi

export HOST_OUTPUT_DIR="$(pwd)/jdk8-with-graal-docker"
mkdir -p "${HOST_OUTPUT_DIR}"
export BUILD_LOGS="${HOST_OUTPUT_DIR}/docker-build.logs"

export CONTAINER_SCRIPTS_DIR="${CONTAINER_HOME_DIR}/scripts"
export CONTAINER_OUTPUT_DIR="${CONTAINER_HOME_DIR}/output"

echo "*************************************************"
echo "* "
echo "* Building image and running container ${DOCKER_IMAGE_TAG}"
echo "* "
echo "* Build logs are sent to a separate log, run the below command to see logs"
echo "* tail -f ${HOST_OUTPUT_DIR}/docker-build.logs"
echo "* "
echo "*************************************************"

echo "******************* Parameters ******************"
echo "DEBUG=${DEBUG}"
echo ""
echo "JAVA_VERSION=${JAVA_VERSION}"
echo "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}"
echo "JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG}"
echo "MAKE_VERSION=${MAKE_VERSION}"
echo ""
echo "HOST_OUTPUT_DIR=${HOST_OUTPUT_DIR}"
echo "HOST_REPOS_DIR=${HOST_REPOS_DIR}"
echo ""
echo "USER_IN_CONTAINER=${USER_IN_CONTAINER}"
echo "CONTAINER_HOME_DIR=${CONTAINER_HOME_DIR}"
echo "CONTAINER_SCRIPTS_DIR=${CONTAINER_SCRIPTS_DIR}"
echo "CONTAINER_OUTPUT_DIR=${CONTAINER_OUTPUT_DIR}"
echo ""
echo "BUILD_LOGS=${BUILD_LOGS}"
echo "RUN_TESTS=${RUN_TESTS}"
echo "DOCKER_JAVA_OPTS=${DOCKER_JAVA_OPTS}"
echo "DOCKER_MEMORY=${DOCKER_MEMORY}"
echo "JAVA_HOME=${JAVA_HOME}"
echo "*************************************************"

./build-docker-image.sh

./run-docker-container.sh

echo "*************************************************"
echo "* "
echo "* Finished running container ${DOCKER_IMAGE_TAG}"
echo "* "
echo "*************************************************"
