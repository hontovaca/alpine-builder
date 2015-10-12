#!/bin/bash
mkdir -p ~/.docker; echo "$hub_json" > ~/.docker/config.json

git fetch --depth=1 origin versions:versions
git clone -b versions . versions

for spec in versions/*; do
  (. "$spec"
  docker run vaca/builder -s $build_opts | docker import - build
  for tag in $hub_tags; do
    docker tag build $hub_repo:$tag
    docker push $hub_repo:$tag
  done)
done
