#!/usr/bin/env bash

set -e
set -u
set -o pipefail

DEPENDENCIES="graal graaljs graal-jvmci-8 jdk8-with-graal mx make-3*.tar.gz make-3*"
GRAALVM_SUITE_DEPENDENCIES="fastr sulong graal-js graalpython truffleruby"

echo "Removing build tooling and dependencies: ${DEPENDENCIES}"
rm -fr ${DEPENDENCIES}
rm -fr ${GRAALVM_SUITE_DEPENDENCIES}
