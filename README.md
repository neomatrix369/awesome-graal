# Awesome Graal [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

---

**CircleCI:**  _Graal JDK8 (Linux)_ [![CircleCI](https://circleci.com/gh/neomatrix369/awesome-graal/tree/master.svg?style=svg)](https://circleci.com/gh/neomatrix369/awesome-graal/tree/master) | _GraalVM Suite JDK8 (Linux)_ [![CircleCI](https://circleci.com/gh/neomatrix369/awesome-graal/tree/build-graalvm-suite.svg?style=svg)](https://circleci.com/gh/neomatrix369/awesome-graal/tree/build-graalvm-suite)<br/>
**AdoptOpenJDK build farm:** _Linux_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_linux)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_linux/)   ⚫   _MacOS_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_macos)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_macos/)   ⚫   _Windows_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_windows)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_windows/)

---

Graal compiler (JDK8, python 2.7, 3.6 & 3.7): [![Graal compiler (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graal-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graal-jdk8) | GraalVM Suite (JDK8, python 2.7, 3.6 & 3.7): [![GraalVM Suite (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graalvm-suite-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graalvm-suite-jdk8) | Dataiku DSS on GraalVM: [![Dataiku DSS](https://img.shields.io/docker/pulls/neomatrix369/dataiku-dss.svg)](https://hub.docker.com/r/neomatrix369/dataiku-dss) | Grakn on GraalVM: [![Grakn](https://img.shields.io/docker/pulls/neomatrix369/grakn.svg)](https://hub.docker.com/r/neomatrix369/grakn) | Jupyter-Java on GraalVM: [![Jupyter-Java](https://img.shields.io/docker/pulls/neomatrix369/jupyter-java.svg)](https://hub.docker.com/r/neomatrix369/jupyter-java) | MLPMNist using DL4J on GraalVM: [![MLPMNist using DL4J on GraalVM](https://img.shields.io/docker/pulls/neomatrix369/dl4j-mnist-single-layer.svg)](https://hub.docker.com/r/neomatrix369/dl4j-mnist-single-layer) | Zeppelin on GraalVM: [![Zeppelin](https://img.shields.io/docker/pulls/neomatrix369/zeppelin.svg)](https://hub.docker.com/r/neomatrix369/zeppelin)

---

A curated list of awesome resources for Graal, GraalVM, Truffle and related topics.

**This repo is dedicated to computer engineers/scientists, compiler/VM engineers, developers, open-source enthusiatics, Graal/GraalVM/Truffle fans and all other professions that take interest in these topics. To make learning interesting and to create a place to easily find all the necessary material. Please contribute, watch, star, fork and share the repo with others in your community.**

- [Awesome Graal](#awesome-graal)
  - [Languages & Platforms](#languages--platforms)
  - [Related JEPs](#related-jeps)
  - [Community](#community)
  - [Github links](#github-links)
  - [Mercurial links](#mercurial-links)
  - [Download links](#download-links)
  - [Projects, Wikipedia pages, discussion forums & blog posts](#projects-wikipedia-pages-discussion-forums--blog-posts)
  - [Papers, presentations/slides & videos](#papers-presentationsslides--videos)
  - [Hands-on pages](#hands-on-pages)
  - [Special topics](#special-topics-java-graal-gpus-accelerators-etc)
- [Contributing](#contributing)

### Languages & Platforms

#### Java & other JVM languages
- [Why?](https://www.graalvm.org/docs/why-graal/#for-java-programs)
- [Getting Started: Running Java](https://www.graalvm.org/docs/getting-started/#running-java)
- Examples
    - [Dataiku Data Science Studio](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/examples/data/dataiku/README.md) | [folder](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/examples/data/dataiku/)
    - [Java Performance Examples](https://www.graalvm.org/docs/examples/java-performance-examples/)
    - [Java stream API benchmark](https://www.graalvm.org/docs/examples/java-simple-stream-benchmark/)
    - [Grakn/Graql graph database](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/data/databases/graph/grakn/README.md) | [folder](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/data/databases/graph/grakn)
    - [Java/Kotlin Native Example](https://www.graalvm.org/docs/examples/java-kotlin-aot/)
    - [Native Image Example](https://www.graalvm.org/docs/examples/native-list-dir/)
    - [Native-image: using Profile Guide Optimisation options](https://github.com/graalvm/graalvm-demos/tree/master/scala-days-2018/streams#profile-guided-optimizations-with-native-image) | Slide 18](https://static.rainfocus.com/oracle/oow18/sess/1526041579721001pM2J/PF/2018-10-24%20SubstrateVM%20CodeOne_15404788159460019swO.pdf)
    - [Command line apps with Clojure and GraalVM](https://www.astrecipes.net/blog/2018/07/20/cmd-line-apps-with-clojure-and-graalvm/)
    - [GraalVM Polyglot with Clojure and JavaScript](https://blog.taylorwood.io/2018/11/26/graal-polyglot.html)
    - [Clojure: GraalVM Native Image HTTPS Support](https://blog.taylorwood.io/2018/10/04/graalvm-https.html)
    - [Building native Clojure images with GraalVM](https://blog.taylorwood.io/2018/05/02/graalvm-clojure.html)
    - [Clojure Hello World example](./examples/clojure/helloworld/README.md) | [folder](./examples/clojure/helloworld)
    - [GraalVM with Groovy](https://e.printstacktrace.blog/graalvm-and-groovy-how-to-start/) | [native image](https://e.printstacktrace.blog/graalvm-groovy-grape-creating-native-image-of-standalone-script/)
    - [GraalVM and Scala](https://medium.com/graalvm/compiling-scala-faster-with-graalvm-86c5c0857fa3) | [Scala compiler faster & slimmer](https://www.codacy.com/blog/scala-faster-and-slimmer-with-graalvm/)
    - [Scala-days-2018 demo](https://github.com/graalvm/graalvm-demos/tree/master/scala-days-2018)
- [Compatibility](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [GraalVM Updater](https://www.graalvm.org/docs/reference-manual/graal-updater/)
- [Reference Manual: JVM languages](https://www.graalvm.org/docs/reference-manual/languages/jvm/)
- [Polyglot Reference](https://www.graalvm.org/docs/reference-manual/polyglot/) | [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)
- [Tools Reference](https://www.graalvm.org/docs/reference-manual/tools/)
- [Native Images](https://www.graalvm.org/docs/reference-manual/aot-compilation/)

#### Python, R, Ruby
- [Why?](https://www.graalvm.org/docs/why-graal/#for-ruby-r-or-python)
- [Get Started: Running Python](https://www.graalvm.org/docs/getting-started/#running-python)
- [Get Started: Running R](https://www.graalvm.org/docs/getting-started/#running-r)
- [Get Started: Running Ruby](https://www.graalvm.org/docs/getting-started/#running-ruby)
- Examples
    - [JavaScript, Java, R Polyglot Application](https://www.graalvm.org/docs/examples/polyglot-javascript-java-r/)
    - [R's graphical output in Java based desktop application](https://github.com/graalvm/examples/tree/master/fastr_javaui)
    - [FastR Node.js interop example](https://github.com/graalvm/examples/tree/master/fastr_node)
    - [A simple, straightforward implementation of "Conway's Game of Life"](https://github.com/graalvm/examples/tree/master/fastr_scalar)
    - [rJava package and built-in Java interoperability in FastR](https://github.com/graalvm/examples/tree/master/r_java_bench)
    - [Embedding R as a scripting language into JVM applications](https://github.com/graalvm/examples/tree/master/r_java_embedding)
    - [Weather Predictor Application: R, Ruby, Java, NodeJS/JS](https://github.com/graalvm/examples/tree/master/weather_predictor)
    - [GraalVM demos: Another Polyglot JavaScript, Java, R application](https://github.com/graalvm/graalvm-demos/tree/master/functionGraphDemo)
    - [Galaaz Demo: GraalVM, TruffleRuby, FastR, ggplot2, gridExtra](https://github.com/graalvm/graalvm-demos/tree/master/galaaz-ggplot)
    - [GraalVM demos: Polyglot JavaScript, Java, R application](https://github.com/graalvm/graalvm-demos/tree/master/polyglot-javascript-java-r)
    - [GraalVM demos: Spring Boot using R packages demo](https://github.com/graalvm/graalvm-demos/tree/master/spring-r)
- [Compatibility](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [GraalVM Updater](https://www.graalvm.org/docs/reference-manual/graal-updater/)
- [Reference Manual: Python](https://www.graalvm.org/docs/reference-manual/languages/python/)
- [Reference Manual: R](https://www.graalvm.org/docs/reference-manual/languages/r/)
- [Reference Manual: Ruby](https://www.graalvm.org/docs/reference-manual/languages/ruby/)
- [Polyglot Reference](https://www.graalvm.org/docs/reference-manual/polyglot/) | [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)
- [Tools Reference](https://www.graalvm.org/docs/reference-manual/tools/)
- [Native Images](https://www.graalvm.org/docs/reference-manual/aot-compilation/)

#### JRuby

- [Running JRuby on the Graal JIT](http://blog.headius.com/2018/07/running-jruby-on-graal-jit.html)

#### Javascript / NodeJS

- [Why?](https://www.graalvm.org/docs/why-graal/#for-nodejs-programs)
- [Getting Started](https://www.graalvm.org/docs/getting-started/#running-javascript)
- Examples
  - [JavaScript, Java, R Polyglot Application](https://www.graalvm.org/docs/examples/polyglot-javascript-java-r/)
  - [Running JavaScript Functions as Stored Procedures in Database](https://www.graalvm.org/docs/examples/mle-oracle/)
  - [Oracle Database Example](https://www.graalvm.org/docs/examples/mle-oracle/)
  - [GraalVM demos: Another Polyglot JavaScript, Java, R application](https://github.com/graalvm/graalvm-demos/tree/master/functionGraphDemo)
  - [Galaaz Demo: GraalVM, TruffleRuby, FastR, ggplot2, gridExtra](https://github.com/graalvm/graalvm-demos/tree/master/galaaz-ggplot)
  - [GraalVM demos: Polyglot JavaScript, Java, R application](https://github.com/graalvm/graalvm-demos/tree/master/polyglot-javascript-java-r)
- [GraalVM Updater](https://www.graalvm.org/docs/reference-manual/graal-updater/)
- [Compatibility](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/languages/js/)

#### Polyglot

- [Getting started: combined languages](https://www.graalvm.org/docs/getting-started/#combine-languages)
- Examples
  - [Polyglot JavaScript, Java, R application](https://www.graalvm.org/docs/examples/polyglot-javascript-java-r/) 
  - [GraalVM Polyglot with Clojure and JavaScript](https://blog.taylorwood.io/2018/11/26/graal-polyglot.html)
- [Language Compatibility Tool](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [GraalVM Updater](https://www.graalvm.org/docs/reference-manual/graal-updater/)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/polyglot/) | [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)
- [GraalVM as a platform: Embed languages](https://www.graalvm.org/docs/graalvm-as-a-platform/embed/)
- [IPolyglot: A polyglot Jupyter kernel for the GraalVM](https://github.com/hpi-swa/ipolyglot) | [HPI Polyglot Programming Seminar](https://medium.com/graalvm/hpi-polyglot-programming-seminar-3fd06ffa59d2) by [Fabio Niephaus](https://medium.com/u/20b155c97c55?source=post_page-----3fd06ffa59d2----------------------)

#### LLVM

- [Getting Started](https://www.graalvm.org/docs/getting-started/#running-llvm-interpreter)
- [Compatibility](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/languages/llvm/) | [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)


#### Third-Party Language Implementations (not officially supported by GraalVM)

- [SOMns, a Simple Newspeak Implementation](https://github.com/smarr/SOMns)
- [grCUDA, Polyglot CUDA integration for the GraalVM](https://github.com/NVIDIA/grcuda)
- [GraalSqueak, a Squeak/Smalltalk bytecode interpreter with support for the Smalltalk programming environment](https://github.com/hpi-swa/graalsqueak)


#### Your Platforms, languages and Tools

##### Your Platforms

- [Why?](https://www.graalvm.org/docs/why-graal/#for-your-platform)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/tools/)
- [GraalVM as a Platform](https://www.graalvm.org/docs/graalvm-as-a-platform/)
  - [Embed Languages](https://www.graalvm.org/docs/graalvm-as-a-platform/embed/)

##### Your Languages and Tools

- [Why?](https://www.graalvm.org/docs/why-graal/#for-your-languages-and-tools)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/tools/)
- [Implement your language](https://www.graalvm.org/docs/graalvm-as-a-platform/implement-language/)
  - [Truffle Language Implementation Framework](https://github.com/oracle/graal/tree/master/truffle) 
  - [Simple Language framework built using Truffle API](https://github.com/graalvm/simplelanguage)
  - [cesquivias's GitHub page on Truffle](https://cesquivias.github.io/)
    - [Writing a Language in Truffle. Part 1: A Simple, Slow Interpreter](https://cesquivias.github.io/blog/2014/10/13/writing-a-language-in-truffle-part-1-a-simple-slow-interpreter/)
    - [Writing a Language in Truffle. Part 2: Using Truffle and Graal](https://cesquivias.github.io/blog/2014/12/02/writing-a-language-in-truffle-part-2-using-truffle-and-graal/)
    - [Writing a Language in Truffle. Part 3: Making my Language (Much) Faster](https://cesquivias.github.io/blog/2015/01/08/writing-a-language-in-truffle-part-3-making-my-language-much-faster/)
    - [Writing a Language in Truffle. Part 4: Adding Features the Truffle Way](https://cesquivias.github.io/blog/2015/01/15/writing-a-language-in-truffle-part-4-adding-features-the-truffle-way/)
- Examples
  - [implementation of the if statement](https://github.com/graalvm/simplelanguage/blob/master/language/src/main/java/com/oracle/truffle/sl/nodes/controlflow/SLIfNode.java)
  - [A SOM Smalltalk implemented on top of Oracle's Truffle Framework ](https://github.com/SOM-st/TruffleSOM), also see http://som-st.github.io/
  - [Mumbler is a lisp programming language](https://github.com/cesquivias/mumbler)
- [Implement your tools](https://www.graalvm.org/docs/graalvm-as-a-platform/implement-instrument/)

### Performance (startup & runtime)

- [Are We Fast Yet? Comparing Language Implementations with Objects, Closures, and Arrays](https://github.com/smarr/are-we-fast-yet) - by @smarr
- [Investigating startup with bytestacks](https://cl4es.github.io/2018/11/23/Investigating-Startup-Using-Bytestacks.html)
- [Comparison bash script: graal](https://github.com/rmannibucau/docosh/blob/master/graalcomparison.sh)
- [Better Java Streams performance with GraalVM](https://medium.com/graalvm/stream-api-performance-with-graalvm-be6cfe7fbb52)
- [Under the hood of GraalVM JIT optimizations](https://medium.com/graalvm/under-the-hood-of-graalvm-jit-optimizations-d6e931394797)
- [GraalVM 19.1: Compiling Faster](https://medium.com/graalvm/graalvm-19-1-compiling-faster-a0041066dee4?source=collection_home---6------1-----------------------)
- [Isolates and Compressed References: More Flexible and Efficient Memory Management via GraalVM](https://medium.com/graalvm/isolates-and-compressed-references-more-flexible-and-efficient-memory-management-for-graalvm-a044cc50b67e?source=collection_home---6------10-----------------------)
- [GraalVM’s JavaScript engine on JDK11 with high performance](https://medium.com/graalvm/graalvms-javascript-engine-on-jdk11-with-high-performance-3e79f968a819)
- [Compiler Explorer](https://godbolt.org/) - online IDE, run code, see asm, rustic compiler

### Related JEPs

- [JEP 317: Experimental Java-Based JIT Compiler - OpenJDK](http://openjdk.java.net/jeps/317)
- [JEP 243: Java-Level JVM Compiler Interface - OpenJDK](http://openjdk.java.net/jeps/243)
- [JEP 295: Ahead-of-Time Compilation](http://openjdk.java.net/jeps/295) 
- ...others

### Community

- [graal-dev mailing list](http://mail.openjdk.java.net/mailman/listinfo/graal-dev)
- [graal-changes mailing list](http://mail.openjdk.java.net/mailman/listinfo/graal-changes)
- [Gitter channel: graal-core](https://gitter.im/graalvm/graal-core) 
- [Gitter channel: truffleruby](https://gitter.im/graalvm/truffleruby) 
- [Twitter list: Wholly Graal of Compilers](https://twitter.com/theNeomatrix369/lists/wholly-graal-of-compilers) 
- [GraalVM.org community](http://www.graalvm.org/community/) 

### Github links

See [Github links](./github-links.md)

### Mercurial links

- [OpenJDK Graal forest](http://hg.openjdk.java.net/graal)
- [Compiler](http://hg.openjdk.java.net/graal/graal)
- [JavaScript parser](http://hg.openjdk.java.net/graal/graal-js-parser/)
- [JVM Compiler Interface for JDK8](http://hg.openjdk.java.net/graal/graal-jvmci-8/)
- [JVM Compiler Interface for JDK9](http://hg.openjdk.java.net/graal/graal-jvmci-9/)
- Deprecated
    - [Compiler (deprecated by graal-core)](http://hg.openjdk.java.net/graal/graal-compiler/)
    - [Compiler (deprecated by graal)](http://hg.openjdk.java.net/graal/graal-core/)

### Download links
- [GraalVM.org Downloads](http://www.graalvm.org/downloads/)
- Oracle Labs GraalVM
    - [Programming Languages and Runtimes ...](http://www.oracle.com/technetwork/oracle-labs/program-languages/overview/index.html)
    - [Download](http://www.oracle.com/technetwork/oracle-labs/program-languages/downloads/index.html)
    - [Learn more](http://www.oracle.com/technetwork/oracle-labs/program-languages/learnmore/index.html)
    - [Java](http://www.oracle.com/technetwork/oracle-labs/program-languages/java/index.html)    
- [Homebrew Tap for GraalVM](https://github.com/graalvm/homebrew-tap/): `brew cask install graalvm/tap/graalvm-ce`
- [Graal and Truffle Builds (JDK8/OpenJDK8)](http://lafo.ssw.uni-linz.ac.at/builds/)
- [jruby graal-vm-0.19 on Homebrew - Libraries.io](https://libraries.io/homebrew/jruby/graal-vm-0.19)

### Projects, Wikipedia pages, discussion forums & blog posts

#### Project(s)

- [OpenJDK: Graal](http://openjdk.java.net/projects/graal/)

#### Wikipedia page(s), OpenJDK Wiki, collection of useful links

- [Graal (compiler) - Wikipedia](https://en.wikipedia.org/wiki/Graal_(compiler))
- [OpenJDK Graal - Wiki](https://wiki.openjdk.java.net/display/Graal/Main)
- [Graal/GraalVM/Truffle official docs](http://www.graalvm.org/docs/)
    - [Graal/GraalVM/Truffle Getting Started](http://www.graalvm.org/docs/getting-started/)
- [Graal/GraalVM/Truffle official Reference Manual](http://www.graalvm.org/docs/reference-manual/)
- [OpenJDK Graal - Publications and Presentations](https://wiki.openjdk.java.net/display/Graal/Publications+and+Presentations)
- [GraalVM: Official list of publications](http://www.graalvm.org/community/publications/)
- [GraalVM in the press](https://www.graalvm.org/community/press/)
- [Official FAQ on Graal/GraalVM/Truffle](https://www.graalvm.org/docs/faq/)
- [List of useful resources from Stefan Marr](https://gist.github.com/smarr/d1f8f2101b5cc8e14e12)

#### Discussion forum(s)

- [Graalvm (Programming) Questions & Answers - TechQA](http://techqa.info/programming/tag/graalvm)
- [Oracle's Graal-JVM / Truffle for Scala? : scala - Reddit](https://www.reddit.com/r/scala/comments/3lshav/oracles_graaljvm_truffle_for_scala/)
- [Reddit discussions on GraalVM and Scala](https://www.reddit.com/r/scala/comments/8d5xlw/consequences_for_scala_with_the_graalvm/)
- [Graal and Clojure discussions](https://marc.info/?l=openjdk-graal-dev&m=139406384928500&w=2)
- [JIT compiling a subset of Python to x86-64](http://www.elegantreader.com/item/15750700)

#### Blog posts

See [Blog posts](blog-posts.md)

### Papers, presentations/slides & videos

See [Papers, presentations/slides & videos](papers-presentations-slides-videos.md)

### Hands-on pages

- General
    - [Building Wholly Graal with Truffle!](https://neomatrix369.wordpress.com/2018/06/11/building-wholly-graal-with-truffle/)
    - [How to build Graal-enabled JDK8 on CircleCI?](https://medium.com/@neomatrix369/how-to-build-graal-enabled-jdk8-on-circleci-3e20ae07a5d3)

- Graal
    - [Add Graal JIT Compilation to Your JVM Language in 5 Easy Steps ...](http://stefan-marr.de/2015/12/add-graal-jit-compilation-to-your-jvm-language-in-5-easy-steps-step-5/)
    
- GraalVM
    - [GraalVM - APIDesign](http://wiki.apidesign.org/wiki/GraalVM)
    - [Learning to use Wholly GraalVM!](https://neomatrix369.wordpress.com/2017/12/12/learning-to-use-wholly-graalvm/) [reblogged on [Java Advent Calendar](https://www.javaadvent.com/2017/12/learning-use-wholly-graalvm.html)]
    
- Truffle    
    - [LuaTruffle](http://www.luatruffle.org/)

- FastR
    - [Compile and configure FastR in Linux | snatverk](http://snatverk.blogspot.com/2016/05/compile-and-configure-fastr-in-linux.html)

### Special topics (Java, Graal, GPUs, Accelerators, etc...)

See [Special topics](./special-topics.md)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.md) policy.
