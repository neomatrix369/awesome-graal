echo "Running clojure hello world via java -jar command"
time java -jar target/uberjar/helloworld-0.1.0-SNAPSHOT-standalone.jar

echo ""
echo ""

echo "Running clojure hello world via graalvm"
time ./helloworld-0.1.0-SNAPSHOT-standalone
