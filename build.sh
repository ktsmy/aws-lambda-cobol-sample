echo "Building: $1"
docker build -t lambda-cobol:latest .
docker run -it --rm -v `pwd`:/output lambda-cobol cp /lambda-cobol-runner.zip /output/lambda-cobol-$1.zip
echo "Built, file ready: lambda-cobol-$1.zip"