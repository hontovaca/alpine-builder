#!/bin/bash -e

if [ -n "$hub_json" ]; then
  mkdir -p ~/.docker
  echo "$hub_json" > ~/.docker/config.json
fi

if [ -z "$hub_repo" ]; then
  # get something sluggy for the repo (don't rely on it)
  hub_repo=$(cd ..; echo "${PWD##*/}")/${PWD##*/}
fi

git fetch --depth=1 origin master:builder versions:versions
for b in builder versions; do
  git clone -b "$b" . "$b"
done

docker build -t vaca/builder builder

for spec in versions/*; do
  (. "$spec"
  set -- $hub_tags
  docker run vaca/builder -s $build_opts | docker import - "build:$1"
  for tag; do
    docker tag "build:$1" "$hub_repo:$tag"
    docker push "$hub_repo:$tag"
  done)
done
