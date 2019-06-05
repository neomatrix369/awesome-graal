# Awesome Graal [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

---

**CircleCI:**  _Linux_  [![CircleCI](https://circleci.com/gh/neomatrix369/awesome-graal/tree/build-graalvm-suite.svg?style=svg)](https://circleci.com/gh/neomatrix369/awesome-graal/tree/build-graalvm-suite) <br/>
**AdoptOpenJDK build farm:** _Linux (pending)_   ⚫   _MacOS_ [![Build Status](https://ci.adoptopenjdk.net/buildStatus/icon?job=GraalVM-suite-jdk8_x86-64_macos)](https://ci.adoptopenjdk.net/job/GraalVM-suite-jdk8_x86-64_macos/)   ⚫   _Windows (pending)_

---

Graal compiler (JDK8): [![Graal compiler (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graal-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graal-jdk8) | GraalVM Suite (JDK8): [![GraalVM Suite (JDK8)](https://img.shields.io/docker/pulls/neomatrix369/graalvm-suite-jdk8.svg)](https://hub.docker.com/r/neomatrix369/graalvm-suite-jdk8)

---

A curated list of awesome resources for Graal, Truffle and related topics.

- [Awesome Graal](#awesome-graal)
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
- [https://github.com/beehive-lab/Maxine-VM](https://github.com/beehive-lab/Maxine-VM) -- [[forks of the project](https://github.com/beehive-lab/Maxine-VM/network/members)]
- [graalvm.github.io by graalvm](https://graalvm.github.io/)
- [GraalVM - GitHub organisation](https://github.com/graalvm)
    - [Graal compiler](https://github.com/oracle/graal)
    - [GitHub - graalvm/graalvm: Graal Multi-Language VM distribution](https://github.com/graalvm/graalvm)
    - [Truffle](https://github.com/graalvm/graal/blob/master/truffle/) | [Truffle documentation](http://graalvm.github.io/graal/truffle/javadoc/com/oracle/truffle/tutorial/package-summary.html)
    - [TruffleRuby](https://github.com/oracle/truffleruby)
    - [FastR](https://github.com/oracle/fastr) | [old Bitbucket location](https://bitbucket.org/allr/fastr/wiki/Home)
    - [Sulong](https://github.com/graalvm/sulong)
    - [A simple demonstration language built using Truffle for the GraalVM.](https://github.com/graalvm/simplelanguage)
    - [Substrate VM](https://github.com/oracle/graal/tree/master/substratevm)
- [GraalVM examples](https://github.com/graalvm/examples)
    - [Node.js+Java Maven Archetype](https://github.com/graalvm/graal-js-archetype)
    - [GraalVM.org Examples](http://www.graalvm.org/docs/examples/)
- [mx - Command-line tool used for the development of Graal projects](https://github.com/graalvm/mx)
- [Fork of jdk8u/hotspot with support for JVMCI](https://github.com/graalvm/graal-jvmci-8)
- [Scripts for building Graal & GraalVM suite (Linux, MacOS, Docker)](build/x86_64/linux_macos)

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
- [List of useful resources from Stefan Marr](https://gist.github.com/smarr/d1f8f2101b5cc8e14e12)

#### Discussion forum(s)

- [Graalvm (Programming) Questions & Answers - TechQA](http://techqa.info/programming/tag/graalvm)
- [Oracle's Graal-JVM / Truffle for Scala? : scala - Reddit](https://www.reddit.com/r/scala/comments/3lshav/oracles_graaljvm_truffle_for_scala/)
- [Graal and Clojure discussions](https://marc.info/?l=openjdk-graal-dev&m=139406384928500&w=2)
- [JIT compiling a subset of Python to x86-64](http://www.elegantreader.com/item/15750700)

#### Blog posts

- General
    - [Chris Seaton’s blog](http://chrisseaton.com/)
    - [Oracle's Graal project empowers language creation on the JVM ...](http://www.infoworld.com/article/2688340/application-development/oracles-graal-project-empowers-language-creation-on-the-jvm.html)
    
- Benchmarking    
    - [Benchmarking a Go AI in Ruby: CRuby vs. Rubinius vs. JRuby vs. Truffle](https://pragtob.wordpress.com/2017/01/24/benchmarking-a-go-ai-in-ruby-cruby-vs-rubinius-vs-jruby-vs-truffle-a-year-later/)

- GraalVM
    - [Getting started with GraalVM - Koichi Sakata | A blog about Java](http://jyukutyo.hatenablog.jp/entry/2017/05/26/135438)
    - [GraalVM and Truffle/JS: Programming Languages and Runtimes ...](https://news.ycombinator.com/item?id=8380627)
    - [GraalVM at a glance - Martin Toshev's blog](http://martin-toshev.com/index.php/software-engineering/tools/87-graalvm)
    - [Setup Graal VM on Mac OS X 10.11 El Capitan Howto Tutorial installation prerequisites](http://www.mensch-und-maschine.de/2016/03/26/setup-graal-vm-on-mac-os-x-10-11-el-capitan-howto-tutorial-installation-prerequisites/)
    - [Top 10 Things To Do With GraalVM](https://medium.com/graalvm/graalvm-ten-things-12d9111f307d)    
    - [Graal VM Options for Graal CE 1.0](https://chriswhocodes.com/graal_options_graal_ce_1.0.html)    
    - [Graal VM Options for Graal EE 1.0](https://chriswhocodes.com/graal_options_graal_ee_1.0.html)    
    - [Evaluating JavaScript in Java with GraalVM](https://amarszalek.net/blog/2018/06/08/evaluating-javascript-in-java-graalvm/)    

- Graal, Truffle    
    - [Graal & Truffle – Mike's blog](https://blog.plan99.net/graal-truffle-134d8f28fb69)
    - [Graal and Truffle could accelerate programming language design ...](http://cesquivias.github.io/tags/truffle.html)
    - [Setup Graal VM on Mac OS X 10.11 El Capitan Howto Tutorial ...](http://www.mensch-und-maschine.de/2016/03/26/setup-graal-vm-on-mac-os-x-10-11-el-capitan-howto-tutorial-installation-prerequisites/)
    - [The Graal Compiler - SSW - JKU](http://ssw.jku.at/Research/Projects/JVM/Graal.html)
    - [Writing a Language in Truffle - Parts 1 thru 4](http://cesquivias.github.io/tags/truffle.html)
    - [Truffle served in a Holy Graal: Graal and Truffle for polyglot language interpretation on the JVM](https://neomatrix369.wordpress.com/2017/12/07/truffle-served-in-a-holy-graal-graal-and-truffle-for-polyglot-language-interpretation-on-the-jvm/) [reblogged on [Java Advent Calendar](https://www.javaadvent.com/2017/12/truffle-served-holy-graal-graal-truffle-polyglot-language-interpretation-jvm.html)]

- TruffleRuby
    - [TruffleRuby by Chris Seaton](http://chrisseaton.com/rubytruffle/)
    - [TruffleRuby on the Substrate VM - Kevin Menard's Weblog](http://nirvdrum.com/2017/02/15/truffleruby-on-the-substrate-vm.html)
    - [Projects That Are Making Blazing Fast Ruby a Reality](https://www.sitepoint.com/projects-that-are-making-blazing-fast-ruby-a-reality/)

- Clojure
    - [Command line apps with Clojure and GraalVM](https://www.astrecipes.net/blog/2018/07/20/cmd-line-apps-with-clojure-and-graalvm/)

### Papers, presentations/slides & videos

- General
    - OpenCL JIT Compilation for Dynamic Programming Languages by four authors: [Paper](https://www.researchgate.net/publication/316923303_OpenCL_JIT_Compilation_for_Dynamic_Programming_Languages)
    - Adaptive Concurrency Control for Transactional Memory by Andy Nisbet: [Slides](http://www.dcs.gla.ac.uk/~jsinger/mmnet15/nisbet.pdf)
    - Bringing Performance and Scalability to Dynamic Languages by Mario Wolczko: [Slides](http://janvitek.org/events/PBD13/slides/MarioWolczko.pdf)
    - (JVMLS 2017): Ahead Of Time (AOT) Internals by Vladimir Kozlov and Igor Veresov: [Video](https://www.youtube.com/watch?v=yyDD_KRdQQU&list=PLX8CzqL3ArzXJ2EGftrmz4SzS6NRr6p2n&index=13)
    - (JCrete): Fastest VM on the planet: [Video](https://www.youtube.com/watch?v=yaWq20AFN9U)    
    - Make a graal-core pull request on GitHub: [Video](https://www.youtube.com/watch?v=A_OczfY-YSg)
    - [GraalVM: Official videos list](http://www.graalvm.org/community/videos/)

- Maxine
    - Maxine A JVM in Java - JUG Saxon by Michael Haupt: [Slides](https://jugsaxony.org/wp-content/uploads/2012/05/Maxine-A_JVM_in_Java.pdf)

- AOT    
    - Compile ahead of time. It's fine? by Dmitry Chuyko: [Slides](https://assets.contentful.com/oxjq45e8ilak/3VZgJf2jLWaQQGKaeSsecc/a015330e94f964d96df0b366321ec068/Dmitry_Chuyko_AOT.pdf)

- Graal, GraalVM, Truffle
    - Graal: A research platform for dynamic compilation and managed... by Christian Wimmer: [Slides](http://cgo.org/cgo2015/event/graal-a-research-platform-for-dynamic-compilation-and-managed-languages/)
    - Graal and Truffle - Modularity by Thomas Wuerthinger: [Slides](https://www.slideshare.net/ThomasWuerthinger/2014-0424-graal-modularity)
    - Graal VM: Multi-Language Execution Platform by Thomas Wuerthinger [Slides](https://www.slideshare.net/ThomasWuerthinger/jazoon2014-slides)        
    - Faster Ruby and JavaScript with GraalVM by Chris Seaton: [Slides](https://speakerdeck.com/chrisseaton/faster-ruby-and-javascript-with-graalvm)    
    - GraalVM - Compiler and JVM Research at JKU - Complang by Josef Eisl: [Slides](https://www.complang.tuwien.ac.at/lehre/ubvo/jku.pdf)
    - JVM++: The Graal VM by Martin Toshev: [Slides](https://www.slideshare.net/martintoshev/jvm-the-graal-vm) | [Video](https://www.youtube.com/watch?v=esC20MSs7E0)
    - New tricks of the GraalVM - Distributed Systems Group by Tõnis Pool: [Slides](http://ds.cs.ut.ee/courses/course-files/newTricksOfGraalVM.pdf)
    - Twitter's quest for a wholly Graal runtime by Chris Thalinger: [Slides](https://downloads.ctfassets.net/oxjq45e8ilak/6eh2A72b4IyWsWOIcig4K0/cbb664566fe86672d92ddfb210623920/Chris_Thalinger_Twitter_s_quest_for_a_wholly_Graal_runtime.pdf) | [Video](https://www.youtube.com/watch?v=ZbccuoaLChk)        
    - (Splash 2016): Truffle and Graal: Fast Programming Languages With Modest Effort by Chris Seaton: [Video](https://www.youtube.com/watch?v=qKZ3BJkXI0c) 
    - (Oracle code): Turning the JVM into a Polyglot VM with Graal by Chris Seaton: [Video](https://www.youtube.com/watch?v=oWX2tpIO4Yc)
    - (VJUG): Turning the JVM into a Polyglot VM with Graal by Chris Seaton: [Video](https://www.youtube.com/watch?v=9oHpAhgkNAY)
    - (Voxxed days): One VM for all by Thomas Wuerthinger: [Video](https://www.youtube.com/watch?v=mMmOntDWSgw)
    - GraalVM – high performance multi language JVM by Lukas Stadler: [Video](https://www.youtube.com/watch?v=9ACoOig_vSk)
    - Graal tutorial at PLDI 2017 conference by Christian Wimmer: [Video](https://www.youtube.com/watch?v=5_Y3kc--eTI)     
    - Graal: How to use the new JVM JIT compiler in real life: [Video](https://www.youtube.com/watch?v=yhtrRhNUHvQ)
    - Graal, GraalVM, Truffle: What do they mean for polyglot developers? by Mani Sarkar: [Slides](http://bit.ly/graal-polyglot-devs) | Video: ([480p](http://crest.cs.ucl.ac.uk/cow/59/videos/sarkar_cow59_480p.mp4) | [720p](http://crest.cs.ucl.ac.uk/cow/59/videos/binkley_cow59_720p.mp4))       
    
- Java, Scala, Kotlin, & JVM languages
    - (JVMLS 2017): Polyglot Native: Java, Scala, Kotlin, & JVM languages by Christian Wimmer: [Video](https://www.youtube.com/watch?v=5BMHIeMXTqA&list=PLX8CzqL3ArzXJ2EGftrmz4SzS6NRr6p2n&index=5)     
 
- Javascript, Node.js
    - (Devoxx BE): Graal.JS - high-performance JavaScript on the JVM by Christian Wirth: [Video](https://www.youtube.com/watch?v=OUo3BFMwQFo)
    - Node.js for Java: [Video](https://www.youtube.com/watch?v=Q_AkHdxBbYw)

- Sulong
    - Sulong: Fast LLVM IR Execution on the JVM with Truffle by Manuel Rigger: [Slides](http://llvm.org/devmtg/2016-01/slides/Sulong.pdf)
    - (JVMLS 2017): Project Sulong, a LLVM bitcode interpreter on the Graal VM by Matthias Grimmer: [Video](https://www.youtube.com/watch?v=n5DCg6M2MDM&list=PLX8CzqL3ArzXJ2EGftrmz4SzS6NRr6p2n&index=14)
    - Native Sulong: [Paper](http://ssw.jku.at/General/Staff/ManuelRigger/VMIL16.pdf) 
    - Safe Sulong: [Paper](http://ssw.jku.at/General/Staff/ManuelRigger/ASPLOS18.pdf)
  
- FastR
    - FastR: Status and Outlook by Michael Haupt: [Slides](http://www.huber.embl.de/dsc/slides/FastR_DSC.pdf)
    - FastR: R on the JVM with the FastR Runtime by Christian Humer: [Slides](http://webcache.googleusercontent.com/search?q=cache:7cz7MRozu-sJ:docs.huihoo.com/javaone/2015/CON5361-R-on-the-JVM-with-the-FastR-Runtime.pdf+&cd=1&hl=en&ct=clnk&gl=uk&client=ubuntu)
    
- Video channel/playlists
    - Graal, GraalVM, Truffle, and family of related tech: [YouTube playlist](https://www.youtube.com/playlist?list=PLUz6BqeCy21T3xPMlzaaIeeKqx-KTwjRC&disable_polymer=true)     

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

- GPUs
   - General 
        - [Just-In-Time GPU Compilation for Interpreted Languages with Partial ...](http://www.research.ed.ac.uk/portal/files/33009999/vee.pdf)
        - [{ projects } | snatverk](http://snatverk.blogspot.com/p/projects.html)
        - [AMD's prototype hsail-‐enabled jdk8 for the openjdk sumatra project](http://developer.amd.com/apu/wp-content/uploads/sites/3/.../HSA-4024_Eric_Caspole.pdf)
        - [A CPU–GPU hybrid approach for the unsymmetric multifrontal method](http://www.sciencedirect.com/science/article/pii/S0167819111001293)

   - Java     
        - [JEP draft: Enable execution of Java methods on GPU](http://openjdk.java.net/jeps/8047074)
        - [API for data parallel Java. Allows suitable code to be executed on GPU via OpenCL](https://code.google.com/archive/p/aparapi/)
        - [OpenJDK Sumatra Project: Bringing the GPU to Java](https://www.youtube.com/watch?v=4ShyMMqjIJI)
        - [Are Java 8 Lambda expressions using GPU? - Stackoverflow discussions](https://stackoverflow.com/questions/30555694/are-java-8-lambda-expressions-using-gpu)
        - [juanfumero / marawacc — Bitbucket](https://bitbucket.org/juanfumero/marawacc)

   - Graal
        - [Wholly Graal: Accelerating GPU Offload for Java - YouTube](https://www.youtube.com/watch?v=uxDd5KfYdJU)
        - [JVMLS 2013: Graal and GPU Offload - Oracle: Video Gallery](https://video.oracle.com/detail/videos/featured-videos/video/2623576344001)
        - [Gpus graal - SlideShare](https://www.slideshare.net/jjfumero/gpus-graal)
        - [PL-4042, Wholly Graal: Accelerating GPU offload for Java/Sumatra...](https://www.slideshare.net/DevCentralAMD/pl4042-vasanthvenkatachalam)
        - [Multicore Maximum Reuse Algorithm on CPU and GPU - graal](http://graal.ens-lyon.fr/~mjacquel/mmre_cpu_gpu.html)

   - FastR
        - [FastR-OpenCL Compiler](https://bitbucket.org/juanfumero/fastr-gpu) 

- Graphics Accelerators
  - [Tornado: Accelerating Java Applications Using GPGPUs](http://on-demand.gputechconf.com/gtc/2016/posters/GTC_2016_Programming_Language_PL_01_P6341_WEB.pdf)
  - [GRAAL: A Framework for LowPower 3D Graphics Accelerators](https://repository.tudelft.nl/islandora/object/uuid:e875b571-129e-4304-ba04-223bd73b2cc3/datastream/OBJ)
  - [GRAAL -- A Development Framework for Embedded Graphics Accelerators](http://dl.acm.org/citation.cfm?id=969105)

- APU
  - [Applying AMD's "Kaveri" APU for Heterogeneous Computing](https://www.hotchips.org/wp-content/uploads/hc_archives/hc26/HC26-11-day1-epub/HC26.11-2-Mobile-Processors-epub/HC26.11.220-Bouvier-Kaveri-AMD-Final.pdf)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.md) policy.
