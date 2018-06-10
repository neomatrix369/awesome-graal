# Building JVMCI for JDK8, Graal & Truffle

The `build.sh` script provided here will clone the respective dependencies to build JVMCI for JDK8, Graal, and Truffle for JDK8. 

Pre-requisite: `JAVA_HOME` should point to the latest version of JDK8 (say build 144 or higher).

Run the below command to start with the building process:

```
./build.sh
```

if you wish to save the `stdout` and `stderr` log messages during the build to a file:

```
./build.sh &> lastBuildOutput.logs
```

To check for consistency of the build script, run the above build command more than once.

Expected messages at the end of a successful build:

```
[snipped]
.
.
.
Archiving GRAAL_TEST... [dependency org.graalvm.compiler.api.test updated]
Archiving TRUFFLE_TEST_NATIVE... [dependency com.oracle.truffle.nfi.test.native updated]
Archiving TRUFFLE_TEST... [dependency com.oracle.truffle.api.test updated]
Compiling com.oracle.truffle.tools.chromeinspector.test with javac-daemon(JDK 1.8)... [dependency TRUFFLE_DSL_PROCESSOR updated]
Archiving CHROMEINSPECTOR_TEST... [dependency com.oracle.truffle.tools.chromeinspector.test updated]
Archiving GRAAL_COMPILER_WHITEBOX_MICRO_BENCHMARKS... [dependency org.graalvm.compiler.virtual.bench updated]
Creating /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal from /path/to/your/awesome-graal/build/x86_64/linux/graal-jvmci-8/jdk1.8.0_144/linux-amd64/product
Copying /path/to/your/awesome-graal/build/x86_64/linux/graal/compiler/mxbuild/dists/graal.jar to /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal/jre/lib/jvmci
Copying /path/to/your/awesome-graal/build/x86_64/linux/graal/compiler/mxbuild/dists/graal-management.jar to /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal/jre/lib/jvmci
Copying /path/to/your/awesome-graal/build/x86_64/linux/graal/sdk/mxbuild/dists/graal-sdk.jar to /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal/jre/lib/boot
Copying /path/to/your/awesome-graal/build/x86_64/linux/graal/truffle/mxbuild/dists/truffle-api.jar to /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal/jre/lib/truffle
>>> All good, now pick your JDK from /path/to/your/awesome-graal/build/x86_64/linux/jdk8-with-graal :-)
```

See build logs alongside the `build.sh` script in this folder.
