echo "Building native image of the uberjar using GraalVM's native-image command"
echo "Ensure GraalVM is installed and added to your PATH environment variable"
native-image -jar target/uberjar/helloworld-*-standalone.jar