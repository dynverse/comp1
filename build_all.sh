#!/bin/bash

for tag in */ ; do
  echo $tag
  docker build ${tag::-1} -t dynverse/dynwrap_tester:${tag::-1}
done

docker push dynverse/dynwrap_tester
