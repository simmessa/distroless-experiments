#!/bin/bash

echo building Distroless container...
docker build test-helloworld -f test-helloworld/Dockerfile -t helloworld-distroless:latest
echo Done.

echo building traditional Alpine container...
docker build test-helloworld -f test-helloworld/Dockerfile-alpine -t helloworld-alpine:latest

