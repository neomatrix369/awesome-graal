#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1

cd ${BASEDIR}/graal/vm
echo "Applying temporary patch to fix graaljs cloning issue in 'mx.vm/suite.py'"
if [[ "$(uname)" = "Darwin" ]]; then
   sed -i '' 's/https:\/\/github.com\/oracle\/js.git/https:\/\/github.com\/graalvm\/graaljs.git/g' mx.vm/suite.py
else
   sed -i 's https://github.com/oracle/js.git https://github.com/graalvm/graaljs.git ' mx.vm/suite.py
fi

echo "Applying temporary patch to fix graalpython cloning issue in 'mx.vm/suite.py'"
if [[ "$(uname)" = "Darwin" ]]; then
    sed -i '' 's/https:\/\/github.com\/oracle\/graalpython.git/https:\/\/github.com\/graalvm\/graalpython.git/g' mx.vm/suite.py
else
    sed -i 's https://github.com/oracle/graalpython.git https://github.com/graalvm/graalpython.git ' mx.vm/suite.py
fi
