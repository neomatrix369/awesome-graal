#!/bin/bash

set -e
set -u
set -o pipefail

if [[ "$(uname)" = "Darwin" ]]; then
  echo "MacOS specific steps"
  echo "Ensure you have the latest version of XCode installed or else you will be prompted to do so"
  brew install llvm@4

  echo "For compilers to find this software you may need to set (check for the correct path):"
  echo "LDFLAGS: -L/usr/local/opt/llvm@4/lib -Wl,-rpath,/usr/local/opt/llvm@4/lib"
  echo "CPPFLAGS: -I/usr/local/opt/llvm@4/include"

else 
  echo "Linux/Unix specific steps"  
  ### Note only version 5.0 and 6.0 are available at the time of creation of this script, see https://apt.llvm.org/
  LLVM_VERSION=${1:-6.0}

  if [ -f "/.dockerenv" ]; then
     echo "Running inside the container environment i.e. Docker"
     sudoCMD=""
  else
     echo "Running in a real OS environment"
     sudoCMD="sudo"
  fi

  ${sudoCMD} apt-get update
  OS_PLATFORM="x86_64-linux-gnu-ubuntu-16.04"
  wget http://releases.llvm.org/${LLVM_VERSION}.0/clang+llvm-${LLVM_VERSION}.0-${OS_PLATFORM}.tar.xz
  tar xf clang+llvm-${LLVM_VERSION}.0-${OS_PLATFORM}.tar.xz
  ${sudoCMD} mv clang+llvm-${LLVM_VERSION}.0-${OS_PLATFORM} /opt/

  echo "Creating softlink for opt at /usr/bin/opt"
  ${sudoCMD} ln -fs "/opt/clang+llvm-${LLVM_VERSION}.0-${OS_PLATFORM}/bin/opt" /usr/bin/opt || true

  export PATH="/opt/clang+llvm-${LLVM_VERSION}.0-${OS_PLATFORM}/bin/opt:${PATH}"
fi
