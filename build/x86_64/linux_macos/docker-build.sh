#!/bin/bash

set -e
set -u
set -o pipefail

if [[ "$(uname)" == "Linux" ]]; then
    sysctl -w fs.file-max=2097152
    sysctl -w vm.max_map_count=67108864
fi 

CURRENT_DIR=$(dirname "$0")

export DEBUG=${DEBUG:-"false"}
export RUN_TESTS=${RUN_TESTS:-"true"}

export JAVA_VERSION=${JAVA_VERSION:-jdk8u212-b03}
export JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG:-"adoptopenjdk/openjdk8:${JAVA_VERSION}"}
export PYTHON_VERSION=${PYTHON_VERSION:-2.7}
export JDK_PYTHON_BASE_IMAGE_TAG="jdk-python-base:${PYTHON_VERSION}"
export DOCKER_IMAGE_TAG="graalvm-suite-jdk8:python-${PYTHON_VERSION}"
export USER_IN_CONTAINER=${USER_IN_CONTAINER:-"graal"}
export GRAAL_JVMCI_8_TAG=${GRAAL_JVMCI_8_TAG:-master}
export CONTAINER_HOME_DIR="/home/${USER_IN_CONTAINER}"
export MAKE_VERSION=${MAKE_VERSION:-4.2.1}
export LLVM_VERSION=${LLVM_VERSION:-6.0}
export RUBY_VERSION=${RUBY_VERSION:-2.2.2}
export GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES:-"/substratevm,/tools,sulong,/graal-nodejs,truffleruby,graalpython,/fastr"}
export DOCKER_MEMORY=4096M
export DOCKER_JAVA_OPTS="-Xms3g -Xmx3g -XX:+PrintFlagsFinal"

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
echo "JDK_PYTHON_BASE_IMAGE_TAG=${JDK_PYTHON_BASE_IMAGE_TAG}"
echo "LLVM_VERSION=${LLVM_VERSION}"
echo "MAKE_VERSION=${MAKE_VERSION}"
echo "RUBY_VERSION=${RUBY_VERSION}"
echo "PYTHON_VERSION=${PYTHON_VERSION}"
echo "GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES}"
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

if [[ "${SKIP_BUILD_IMAGE:-}" = "true" ]]; then
	echo "Not building the docker image, skipping to directly running the docker container..."
else
	${CURRENT_DIR}/build-docker-image.sh
fi

if [[ "${SKIP_RUN_CONTAINER:-}" = "true" ]]; then
	echo "Not running the docker container, exiting now."
else
	${CURRENT_DIR}/run-docker-container.sh
	echo "*************************************************"
	echo "* "
	echo "* Finished running container ${DOCKER_IMAGE_TAG}"
	echo "* "
	echo "*************************************************"
fi

