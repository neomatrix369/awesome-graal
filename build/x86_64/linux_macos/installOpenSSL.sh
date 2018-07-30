#!/bin/bash

# A CA file has been bootstrapped using certificates from the SystemRoots
# keychain. To add additional certificates (e.g. the certificates added in
# the System keychain), place .pem files in
#   /usr/local/etc/openssl/certs

# and run
#   /usr/local/opt/openssl/bin/c_rehash

# This formula is keg-only, which means it was not symlinked into /usr/local,
# because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.

# If you need to have this software first in your PATH run:
#   echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.zshrc

# For compilers to find this software you may need to set:
#     LDFLAGS:  -L/usr/local/opt/openssl/lib
#     CPPFLAGS: -I/usr/local/opt/openssl/include

set -e
set -u
set -o pipefail


if [[ "$(uname)" = "Darwin" ]]; then
  echo "MacOS specific steps"
  echo "Ensure you have the latest version of XCode installed or else you will be prompted to do so"
  brew install openssl

  echo "For compilers to find this software you may need to set (check for the correct path):"
  echo "LDFLAGS:  -L/usr/local/opt/openssl/lib"
  echo "CPPFLAGS: -I/usr/local/opt/openssl/include"

  echo ""
  echo "Remapping"
  echo "If libssl is in a non-standard location for your system, you can use the option"
  echo ""
  echo "    -Xcexts.remap=libssl.so:path/to/libssl.so"
else 
  sudo apt-get install libssl-dev \
        && rm -r /var/lib/apt/lists/*
fi
