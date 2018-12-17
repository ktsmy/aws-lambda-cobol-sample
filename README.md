# aws-lambda-cobol-sample

## Requires
- Docker

## Build

```bash
$ ./build.sh
```
Package "lambda-cobol-hello.zip" will be created.

## Create lambda function

```bash
$ aws lambda create-function \
    --function-name hello-cobol \
    --runtime provided \
    --role <execution_role> \  # enter your lambda execution role
    --handler cobol.hello \
    --zip-file fileb://lambda-cobol-hello.zip
```
