#!/usr/bin/env bash

set -e
set -u
set -o pipefail

displayDependencyVersion() {
    versionCheck java
    versionCheck make
    versionCheck python "--version"

    if [[ "$(uname)" = "Darwin" ]]; then
        echo ""
        echo "MacOS specific checks"
        versionCheck xcodebuild "--version" || true
    fi
}
