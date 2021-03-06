#!/bin/bash

#engine
mkdir ~/aevolume
cd ~/aevolume

docker pull docker.io/anchore/anchore-engine:latest
docker create --name ae docker.io/anchore/anchore-engine:latest
docker cp ae:/docker-compose.yaml ~/aevolume/docker-compose.yaml
docker rm ae

docker-compose pull
docker-compose up -d

#cli
pip install --user anchorecli

echo "Please set credentials..."
echo "like this:"
echo "anchore-cli --u admin --p foobar image list"

echo "or via ANCHOR_CLI_USER and ANCHOR_CLI_PASSWORD env vars..."
