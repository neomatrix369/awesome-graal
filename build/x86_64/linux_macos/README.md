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
    - for MacOS - version 3.81 
    - `installMake.sh` has been provided, amend where necessary before running
- Docker (to use the `docker-build.sh` script)
- JDK 1.8 (build 141 or higher)
    - must be a JDK and not just a JRE (some openjdk builds can be)
    - can also be obtained from the [Adopt OpenJDK build farm](https://adoptopenjdk.net/releases.html?variant=openjdk8)
- Python 2.7 or higher

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

- The build logs are written to the `jdk8-with-graal-docker/docker-build.logs` log file:

```
tail -f jdk8-with-graal-docker/docker-build.logs
```

```
[<ENV VARIABLE>="<value>"]* ./docker-build.sh
```
*one of more environment variables

```
DEBUG=true HOST_REPOS_DIR="/path/on/the/host" ./docker-build.sh
```

or 

```
DEBUG=true HOST_REPOS_DIR="/path/on/the/host" [other env variables] ./run-docker-container.sh
```


- All the known environment variables that can be used when running the above `docker-build.sh` script:

| Name           | Default       | Description |
| :------------- |:-------------:|:------------|
| DEBUG | <empty> | to run the container in DEBUG mode |
| HOST_REPOS_DIR | /home/graal/ (inside the container)| a new location on the host to map all the source and dependent repos used to build Graal/GraalVM/Truffle |
| JDK_BASE_IMAGE | openjdk8 | name of the JDK image (from Adopt OpenJDK build farm or another source) |
| JDK_TAG_NAME | jdk8u212-b03 | the tag name  of the the image |
| USER_IN_CONTAINER | graal | name of the user in the container (when in debug or non-debug mode)  |
| HOST_REPOS_DIR | <empty>  | location on the host machine to map all the Graal/GraalVM/Truffle source and dependent repos, this is usually done inside the container |
| SKIP_BUILD_IMAGE | <empty>  | run the script but only build the docker image |
| SKIP_RUN_CONTAINER | <empty>  | run the script but only run the docker container, skip the build part, use existing image |
| PYTHON_VERSION | 2.7  | build docker image based on specified python version, options: 2.7 or 3.7 |
| MAKE_VERSION | 4.2.1 | build docker image based on specified make version, options: open, subject to available source |

### Docker image & container

If you examine the `Dockerfile` script, you will see the docker image is inherited from `adoptopenjdk/openjdk8:latest` available from the docker user [Adopt OpenJDK](https://hub.docker.com/u/adoptopenjdk/) on [Docker hub](http://hub.docker.com/).

The script also internally calls `installMake.sh`, this script can also be run in the native environment. It takes the version numbers of the program as a command-line parameter.

Remove unused containers and images:

```
./removeUnusedContainersAndImages.sh
```

Push docker image to Docker hub

`DOCKER_USER_NAME` and `IMAGE_VERSION` environment variables needs setting otherwise the default value will be taken:

```
DOCKER_USER_NAME=someuser IMAGE_VERSION=python-2.7 ./push-graal-docker-image-to-hub.sh
```

Password will be asked before it proceeds with uploading the layers.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](https://github.com/neomatrix369/awesome-graal/blob/master/CONTRIBUTING.md) guidelines, also have a read about our [licensing](https://github.com/neomatrix369/awesome-graal/blob/master/LICENSE.md) policy.

Looking forward to your pull request.
