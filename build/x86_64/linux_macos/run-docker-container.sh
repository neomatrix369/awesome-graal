#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail

HOST_REPOS_DIR_DOCKER_PARAM=""
if [[ ! -z "${HOST_REPOS_DIR}" ]]; then
    mkdir -p "${HOST_REPOS_DIR}"
    HOST_REPOS_DIR_DOCKER_PARAM="--volume ${HOST_REPOS_DIR}:${CONTAINER_HOME_DIR}"
fi

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " INPUT_DOCKER_USER_NAME
  export DOCKER_USER_NAME=${INPUT_DOCKER_USER_NAME}
fi

if [[ "${DEBUG}" = "true" ]]; then
  echo ""
  echo "* Running container ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} in DEBUG mode"
  echo ""
  docker run                                                       \
         --rm                                                      \
         --interactive --tty --entrypoint /bin/bash                \
         --user ${USER_IN_CONTAINER}                               \
         --env SCRIPTS_LIB_DIR=${CONTAINER_HOME_DIR}/scripts/lib   \
         --env OUTPUT_DIR="${CONTAINER_OUTPUT_DIR}"                \
         --env RUN_TESTS="${RUN_TESTS}"                            \
         --env GRAALVM_SUITE_RUNTIMES="${GRAALVM_SUITE_RUNTIMES}"  \
         --env JAVA_OPTS="${DOCKER_JAVA_OPTS}"                     \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                  \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch         \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}       \
         --memory ${DOCKER_MEMORY}                                 \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                            \
         ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG}
else
  echo ""
  echo "* Running container ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} in normal mode"
  echo "* Run the below to tail the build logs inside the Docker container:"
  echo "          tail -f jdk8-with-graal-docker/docker-build.logs"
  echo ""
  docker run                                                         \
         --rm                                                        \
         --user ${USER_IN_CONTAINER}                                 \
         --entrypoint "${CONTAINER_HOME_DIR}/scripts/local-build.sh" \
         --env SCRIPTS_LIB_DIR=${CONTAINER_HOME_DIR}/scripts/lib     \
         --env OUTPUT_DIR="${CONTAINER_OUTPUT_DIR}"                  \
         --env RUN_TESTS="${RUN_TESTS}"                              \
         --env GRAALVM_SUITE_RUNTIMES="${GRAALVM_SUITE_RUNTIMES}"    \
         --env JAVA_OPTS="${DOCKER_JAVA_OPTS}"                       \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                    \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch           \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}         \
         --memory ${DOCKER_MEMORY}                                   \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                              \
         ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} &> ${BUILD_LOGS}
fi