#!/bin/bash

for tag in */ ; do
  echo $tag
  docker build ${tag::-1} -t dynverse/comp1:${tag::-1}
done

docker push dynverse/comp1
