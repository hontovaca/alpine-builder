#!/bin/sh
mkdir -p ~/.docker; echo "$hub_json" > ~/.docker/config.json

docker run --rm vaca/builder -m http://alpine.gliderlabs.com/alpine -es | docker import - $hub_repo:edge
docker push $hub_repo:edge

docker tag $hub_repo:edge $hub_repo:latest
docker push $hub_repo:latest
