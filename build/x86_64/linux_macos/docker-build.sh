#!/bin/bash

set -e
set -u
set -o pipefail

DEBUG=${DEBUG:-""}
RUN_TESTS=${RUN_TESTS:-""}

JDK_BASE_IMAGE=${JDK_BASE_IMAGE:-"openjdk8"}
JDK_TAG_NAME=${JDK_TAG_NAME:-"jdk8u152-b16"}
DOCKER_IMAGE_TAG="graal-jdk8:latest"
USER_IN_CONTAINER=${USER_IN_CONTAINER:-"graal"}
CONTAINER_HOME_DIR="/home/${USER_IN_CONTAINER}"
MAKE_VERSION=${MAKE_VERSION:-3.82}
LLVM_VERSION=${LLVM_VERSION:-6.0}
GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES:-"/substratevm,/tools,sulong,/graal-nodejs,/fastr,truffleruby,graalpython"}
export JAVA_OPTS="$(echo ${JAVA_OPTS:-''} -Xms512m -Xmx512m)"

HOST_REPOS_DIR=${HOST_REPOS_DIR:-""}
if [[ ! -z "${HOST_REPOS_DIR}" ]]; then
    HOST_REPOS_DIR="$(pwd)/jdk8-with-graal-repos"
fi

HOST_OUTPUT_DIR="$(pwd)/jdk8-with-graal-docker"
mkdir -p "${HOST_OUTPUT_DIR}"
BUILD_LOGS="${HOST_OUTPUT_DIR}/docker-build.logs"

CONTAINER_SCRIPTS_DIR="${CONTAINER_HOME_DIR}/scripts"
CONTAINER_OUTPUT_DIR="${CONTAINER_HOME_DIR}/output"

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
echo "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}"
echo "JDK_BASE_IMAGE=${JDK_BASE_IMAGE}"
echo "JDK_TAG_NAME=${JDK_TAG_NAME}"
echo "LLVM_VERSION=${LLVM_VERSION}"
echo "MAKE_VERSION=${MAKE_VERSION}"
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
echo "JAVA_OPTS=${JAVA_OPTS}"
echo "*************************************************"

docker build \
            -t ${DOCKER_IMAGE_TAG} \
            --build-arg USER_IN_CONTAINER=${USER_IN_CONTAINER} \
            --build-arg JDK_BASE_IMAGE=${JDK_BASE_IMAGE}       \
            --build-arg JDK_TAG_NAME=${JDK_TAG_NAME}           \
            --build-arg MAKE_VERSION=${MAKE_VERSION}           \
            --build-arg LLVM_VERSION=${LLVM_VERSION} .

HOST_REPOS_DIR_DOCKER_PARAM=""
if [[ ! -z "${HOST_REPOS_DIR}" ]]; then
    mkdir -p "${HOST_REPOS_DIR}"
    HOST_REPOS_DIR_DOCKER_PARAM="--volume ${HOST_REPOS_DIR}:${CONTAINER_HOME_DIR}"
fi

if [[ "${DEBUG}" = "true" ]]; then
  echo "* Running container ${DOCKER_IMAGE_TAG} in DEBUG mode"
  docker run                                                       \
         --rm                                                      \
         --interactive --tty --entrypoint /bin/bash                \
         --user ${USER_IN_CONTAINER}                               \
         --env OUTPUT_DIR=${CONTAINER_OUTPUT_DIR}                  \
         --env RUN_TESTS=${RUN_TESTS}                              \
         --env GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES}    \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                  \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch         \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}       \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                            \
         ${DOCKER_IMAGE_TAG}
else   
  docker run                                                       \
         --rm                                                      \
         --user ${USER_IN_CONTAINER}                               \
         --entrypoint ${CONTAINER_HOME_DIR}/scripts/local-build.sh \
         --env OUTPUT_DIR=${CONTAINER_OUTPUT_DIR}                  \
         --env RUN_TESTS=${RUN_TESTS}                              \
         --env GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES}    \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                  \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch         \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}       \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                            \
         ${DOCKER_IMAGE_TAG} &> ${BUILD_LOGS}
fi

echo "*************************************************"
echo "* "
echo "* Finished running container ${DOCKER_IMAGE_TAG}"
echo "* "
echo "*************************************************"
