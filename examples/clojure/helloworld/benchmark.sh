echo "Running clojure hello world via java -jar command"
time java -jar target/uberjar/helloworld-0.1.0-SNAPSHOT-standalone.jar

echo ""
echo ""

echo "Running clojure hello world via graalvm"
NATIVE_IMAGE_FILE=$(ls helloworld-*-standalone)
time ./${NATIVE_IMAGE_FILE}
