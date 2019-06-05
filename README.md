# Awesome Graal [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

---

**CircleCI:**  _Linux_ [![CircleCI](https://circleci.com/gh/neomatrix369/awesome-graal/tree/master.svg?style=svg)](https://circleci.com/gh/neomatrix369/awesome-graal/tree/master) <br/>
**AdoptOpenJDK build farm:** _Linux_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_linux)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_linux/)   ⚫   _MacOS_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_macos)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_macos/)   ⚫   _Windows_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=jdk8-with-graal_build_x86-64_windows)](https://ci.adoptopenjdk.net/job/jdk8-with-graal_build_x86-64_windows/)

---

Graal compiler (JDK8): [![Graal compiler (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graal-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graal-jdk8) | GraalVM Suite (JDK8): [![GraalVM Suite (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graalvm-suite-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graalvm-suite-jdk8)

---

A curated list of awesome resources for Graal, Truffle and related topics.

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
    - [Java Performance Examples](https://www.graalvm.org/docs/examples/java-performance-examples/)
    - [Java stream API benchmark](https://www.graalvm.org/docs/examples/java-simple-stream-benchmark/)
    - [Grakn/Graql graph database](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/data/databases/graph/grakn/README.md) | [folder](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/data/databases/graph/grakn)
    - [Java/Kotlin Native Example](https://www.graalvm.org/docs/examples/java-kotlin-aot/)
    - [Native Image Example](https://www.graalvm.org/docs/examples/native-list-dir/)
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

#### LLVM

- [Getting Started](https://www.graalvm.org/docs/getting-started/#running-llvm-interpreter)
- [Compatibility](https://www.graalvm.org/docs/reference-manual/compatibility/)
- [Reference Manual](https://www.graalvm.org/docs/reference-manual/languages/llvm/) | [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)

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
- [Implement your tools](https://www.graalvm.org/docs/graalvm-as-a-platform/implement-instrument/)

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
- [Graal and Truffle Builds (JDK8/OpenJDK8)](http://lafo.ssw.uni-linz.ac.at/builds/)
- [jruby graal-vm-0.19 on Homebrew - Libraries.io](https://libraries.io/homebrew/jruby/graal-vm-0.19)
- Oracle Labs GraalVM
    - [Programming Languages and Runtimes ...](http://www.oracle.com/technetwork/oracle-labs/program-languages/overview/index.html)
    - [Download](http://www.oracle.com/technetwork/oracle-labs/program-languages/downloads/index.html)
    - [Learn more](http://www.oracle.com/technetwork/oracle-labs/program-languages/learnmore/index.html)
    - [Java](http://www.oracle.com/technetwork/oracle-labs/program-languages/java/index.html)    
- [GraalVM.org Downloads](http://www.graalvm.org/downloads/)

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