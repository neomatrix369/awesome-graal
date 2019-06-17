#!/bin/bash

set -e
set -u
set -o pipefail

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

echo ""
echo "* Downloading and install JDK from AdoptOpenJDK build farm"
echo ""

wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b04/OpenJDK8U-jdk_x64_linux_hotspot_8u212b04.tar.gz
tar xvzf OpenJDK8U-jdk_x64_linux_hotspot_8u212b04.tar.gz
${SUDO_CMD} rm -fr /usr/lib/jvm/jdk1.8.0
${SUDO_CMD} mv jdk8u212-b04 /usr/lib/jvm/jdk1.8.0

export JAVA_HOME=/usr/lib/jvm/jdk1.8.0

${SUDO_CMD} update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0/bin/java 1
${SUDO_CMD} update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0/bin/javac 1

${SUDO_CMD} update-alternatives --set java /usr/lib/jvm/jdk1.8.0/bin/java
${SUDO_CMD} update-alternatives --set javac /usr/lib/jvm/jdk1.8.0/bin/javac