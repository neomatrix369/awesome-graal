#!/bin/bash

set -e
set -u
set -o pipefail

HOST_REPOS_DIR_DOCKER_PARAM=""
if [[ ! -z "${HOST_REPOS_DIR}" ]]; then
    mkdir -p "${HOST_REPOS_DIR}"
    HOST_REPOS_DIR_DOCKER_PARAM="--volume ${HOST_REPOS_DIR}:${CONTAINER_HOME_DIR}"
fi

if [[ "${DEBUG}" = "true" ]]; then
  echo ""
  echo "* Running container ${DOCKER_IMAGE_TAG} in DEBUG mode"
  echo ""
  docker run                                                       \
         --rm                                                      \
         --interactive --tty --entrypoint /bin/bash                \
         --user ${USER_IN_CONTAINER}                               \
         --env SCRIPTS_LIB_DIR=${CONTAINER_HOME_DIR}/scripts/lib   \
         --env OUTPUT_DIR="${CONTAINER_OUTPUT_DIR}"                \
         --env RUN_TESTS="${RUN_TESTS}"                            \
         --env JAVA_OPTS="${DOCKER_JAVA_OPTS}"                     \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                  \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch         \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}       \
         --memory ${DOCKER_MEMORY}                                              \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                            \
         ${DOCKER_IMAGE_TAG}
else
  echo ""
  echo "* Running container ${DOCKER_IMAGE_TAG} in normal mode"
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
         --env JAVA_OPTS="${DOCKER_JAVA_OPTS}"                       \
         --volume $(pwd):${CONTAINER_SCRIPTS_DIR}                    \
         --volume $(pwd)/patch:${CONTAINER_HOME_DIR}/patch           \
         --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}         \
         --memory ${DOCKER_MEMORY}                                   \
         ${HOST_REPOS_DIR_DOCKER_PARAM}                              \
         ${DOCKER_IMAGE_TAG} &> ${BUILD_LOGS}
fi
