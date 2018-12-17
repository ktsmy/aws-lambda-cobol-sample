#!/bin/bash
docker build -t lambda-cobol:latest .
docker run -it --rm -v `pwd`:/tmp lambda-cobol cp /lambda-cobol-hello.zip /tmp/
