# helloworld [![License](https://img.shields.io/badge/License-EPL%201.0-red.svg)](https://opensource.org/licenses/EPL-1.0)

A helloworld application written in clojure built and run on GraalVM

## Dependencies

- Clojure 1.8 or higher
- Leiningen 1.0.0 or higher
- GraalVM 0.32 or higher

## Build

	$ lein uberjar    --- builds the uberjar in the target folder

In case, you get an error like this "javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target" or something similar to the security certificate missing, please follow the steps mentioned at https://github.com/oracle/graal/issues/493#issuecomment-447582907. Its due to missing or an incorrect `cacert` present in the $JAVA_HOME/lib/security or $JAVA_HOME/jre/lib/security folders.

	$ native-image -jar target/uberjar/helloworld-0.1.0-SNAPSHOT-standalone.jar    --- builds the native image of the above jar

## Usage

    $ java -jar target/uberjar/helloworld-0.1.0-standalone.jar

    $ ./helloworld-0.1.0-SNAPSHOT-standalone

## Scripts

`benchmark.sh` and `footprint.sh` have been provided to be able to compare performance benchmarks and footprints of traditional JVM and GraalVM built Jar applications.

These scripts need both the standalone jar and native image files present to work.

Metrics from both scripts:

`benchmark.sh`

```
Running clojure hello world via java -jar command
Hello, World!

real	0m2.199s
user	0m4.227s
sys	0m0.358s


Running clojure hello world via graalvm
Hello, World!

real	0m0.098s
user	0m0.005s
sys	0m0.005s
```

`footprint.sh`

```
Footprint of clojure hello world jar
8512 -rw-r--r--  1 swami  staff   3.5M  9 Oct 22:54 target/uberjar/helloworld-0.1.0-SNAPSHOT-standalone.jar

plus the size of the jre that we bundle with the standalone jar
190M	/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home/jre


Footprint of clojure hello world graalvm native image
15888 -rwxr-xr-x  1 swami  staff   7.8M  9 Oct 22:57 ./helloworld-0.1.0-SNAPSHOT-standalone
```

## License

Copyright © 2019

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
