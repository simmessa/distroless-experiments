# Distroless Docker experiments

Inside this repository you'll find some instruments to assess container security plus a proof of concept of Distroless container security:

## anchore

Here you will find a script to quickly setup anchore engine + cli via docker-compose, there's also some results of scan performed on the provided docker images updated @ 26/1/2020

## test-helloworld

This is a simple python Flask app which exposes an "hello world" service, no ports are exposed since the containers are used only for static analysis of vulnerabilities based on dependencies.

The app is meant to be containerized and there are two Dockerfiles:

- Dockerfile-alpine

- Dockerfile

## test-helloworld

This is your average nginx (v1.17.8) built statically and containerized using a distroless base image