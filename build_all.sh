#!/bin/bash

for tag in */ ; do
  echo "> docker build ${tag::-1} -t dynverse/dynwrap_tester:${tag::-1}"
  docker build ${tag::-1} -t dynverse/dynwrap_tester:${tag::-1}
done

docker tag dynverse/dynwrap_tester:R_text dynverse/dynwrap_tester:latest
docker push dynverse/dynwrap_tester
