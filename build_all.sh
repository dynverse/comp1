#!/bin/bash

for tag in */ ; do
  echo $tag
  docker build ${tag::-1} -t dynverse/dynwrap:${tag::-1}
done

docker push dynverse/dynwrap
