# Distroless Docker experiments

Inside this repository you'll find some instruments to assess container security plus a proof of concept of Distroless container security:

## test-helloworld

This is a simple python Flask app which exposes an "hello world" service, no ports are exposed since the containers are used only for static analysis of vulnerabilities based on dependencies.

The app is meant to be containerized and there are two Dockerfiles:

- Dockerfile-alpine

- Dockerfile

This is

- anchore
