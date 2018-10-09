echo "Footprint of clojure hello world jar"
ls -lsah target/uberjar/helloworld-0.1.0-SNAPSHOT-standalone.jar

echo "\nplus the size of the jre that we bundle with the standalone jar"
du -sh $JAVA_HOME/jre

echo ""
echo ""

echo "Footprint of clojure hello world graalvm native image"
ls -lsah ./helloworld-0.1.0-SNAPSHOT-standalone
