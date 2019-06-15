#!/bin/bash

set -e
set -u
set -o pipefail

echo ""
echo "* Building base docker image ${JDK_PYTHON_BASE_IMAGE_TAG}"
echo ""

docker build \
            -t ${JDK_PYTHON_BASE_IMAGE_TAG} \
            --build-arg JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG} \
            -f Dockerfile-python-${PYTHON_VERSION:-2.7} .

echo ""
echo "* Building docker image ${DOCKER_IMAGE_TAG}, inheriting from base image ${JDK_PYTHON_BASE_IMAGE_TAG}"
echo ""

docker build \
            -t ${DOCKER_IMAGE_TAG} \
            --build-arg USER_IN_CONTAINER=${USER_IN_CONTAINER}                 \
            --build-arg JAVA_VERSION=${JAVA_VERSION}                           \
            --build-arg GRAAL_JVMCI_8_TAG=${GRAAL_JVMCI_8_TAG}                 \
            --build-arg JDK_PYTHON_BASE_IMAGE_TAG=${JDK_PYTHON_BASE_IMAGE_TAG} \
            --build-arg MAKE_VERSION=${MAKE_VERSION}                           \
            --build-arg PYTHON_VERSION=${PYTHON_VERSION}                       \
            -f Dockerfile .