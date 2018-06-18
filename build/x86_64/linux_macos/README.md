# Building JVMCI for JDK8, Graal & Truffle

## Pre-requisites

### Platforms & OSes

The scripts in this folder support `x86_64` architecture and can be used both on both Linux and MacOS operating systems.

### Tooling and dependencies

- build-essentials
    - for Linux - (whatever version comes with the distro)
    - for MacOS - xcode 4.9.1 or higher
- make 
    - for Linux - version 3.82  
    - for MacOS - version 3.83 
    - `installMake382.sh` has been provided, run or amend where necessary  
- Docker (to use the `docker-build.sh` script)
- JDK 1.8 (build 141 or higher)
    - must be a JDK and not just a JRE (some openjdk builds can be)

**Note:** 
- building of `graal-jvmci-8` have known to fail if the above versions are not met
- best to try out the `docker-build.sh` script in case `local-build.sh` fails for you in Linux
- in case `local-build.sh` fails on the MacOS, please let us know via the [graal-dev mailing list](http://mail.openjdk.java.net/mailman/listinfo/graal-dev)

## Native build

The `local-build.sh` script provided here will clone the respective dependencies to build JVMCI for JDK8, Graal, and Truffle for JDK8. 

Ensure `JAVA_HOME` should point to the latest version of JDK8 (build 144 or higher).

Run the below command to start with the building process:

```
./local-build.sh
```

if you wish to save the `stdout` and `stderr` log messages during the build to a file:

```
./local-build.sh &> lastBuildOutput.logs
```

To check for consistency of the build script, run the above build command more than once.

Expected messages at the end of a successful build:

```
[snipped]
.
.
.
Archiving GRAAL_MANAGEMENT... [dependency org.graalvm.compiler.hotspot.management updated]
Compiling com.oracle.truffle.api.benchmark with javac-daemon(JDK 1.8)... [dependency TRUFFLE_DSL_PROCESSOR updated]
Compiling org.graalvm.compiler.truffle.test with javac-daemon(JDK 1.8)... [dependency GRAAL_NODEINFO_PROCESSOR updated]
Compiling com.oracle.truffle.tools.profiler.test with javac-daemon(JDK 1.8)... [dependency TRUFFLE_DSL_PROCESSOR updated]
Archiving TRUFFLE_PROFILER_TEST... [dependency com.oracle.truffle.tools.profiler.test updated]
Archiving TRUFFLE_TEST... [dependency com.oracle.truffle.api.test updated]
Archiving GRAAL_TEST... [dependency org.graalvm.compiler.api.test updated]
Compiling com.oracle.truffle.tools.chromeinspector.test with javac-daemon(JDK 1.8)... [dependency TRUFFLE_DSL_PROCESSOR updated]
Archiving CHROMEINSPECTOR_TEST... [dependency com.oracle.truffle.tools.chromeinspector.test updated]
Archiving GRAAL_COMPILER_WHITEBOX_MICRO_BENCHMARKS... [dependency org.graalvm.compiler.virtual.bench updated]
Creating /home/graal/jdk8-with-graal from /home/graal/graal-jvmci-8/openjdk1.8.0-adoptopenjdk/linux-amd64/product
Copying /home/graal/graal/compiler/mxbuild/dists/graal.jar to /home/graal/jdk8-with-graal/jre/lib/jvmci
Copying /home/graal/graal/compiler/mxbuild/dists/graal-management.jar to /home/graal/jdk8-with-graal/jre/lib/jvmci
Copying /home/graal/graal/sdk/mxbuild/dists/graal-sdk.jar to /home/graal/jdk8-with-graal/jre/lib/boot
Copying /home/graal/graal/truffle/mxbuild/dists/truffle-api.jar to /home/graal/jdk8-with-graal/jre/lib/truffle

>>> All good, now pick your JDK from /home/graal/jdk8-with-graal :-)

Creating Archive and SHA of the newly JDK8 with Graal & Truffle at /home/graal/jdk8-with-graal
Creating Archive jdk8-with-graal.tar.gz
Creating a sha5 hash from jdk8-with-graal.tar.gz
jdk8-with-graal.tar.gz and jdk8-with-graal.tar.gz.sha256sum.txt have been successfully created in the /home/graal/output folder.
```

See build logs alongside the `local-build.sh` script in this folder.

Clean up folders created by native image building:

```
cleanup-local-build.sh
```

## Docker build

Run the below command to start with the building process in a Docker container:

```
./docker-build.sh
```

The build logs are written to the `jdk8-with-graal-docker/docker-build.logs` log file:

```
tail -f jdk8-with-graal-docker/docker-build.logs
```

For container in DEBUG mode, run the below:

```
DEBUG=true ./docker-build.sh
```

By default, the output is stored inside the container i.e. '/home/graal/jdk8-with-graal-docker'

To map all the repos used during the build process, run the below:

```
HOST_REPOS_DIR="jdk8-with-graal-repos" ./docker-build.sh
```

By default, the output is stored inside the container i.e. '/home/graal/jdk8-with-graal-docker'

### Docker image & container

If you examine the `Dockerfile` script, you will see the docker image is inherited from `adoptopenjdk/openjdk8:latest` available from the docker user [Adopt OpenJDK](https://hub.docker.com/u/adoptopenjdk/) on [Docker hub](http://hub.docker.com/).

The script also internally calls `installMake382.sh`, this script can also be run in the native environment.

Remove unused containers and images:

```
./removeUnusedContainersAndImages.sh
```

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](https://github.com/neomatrix369/awesome-graal/blob/master/CONTRIBUTING.md) guidelines, also have a read about our [licensing](https://github.com/neomatrix369/awesome-graal/blob/master/LICENSE.md) policy.

Looking forward to your pull request.
