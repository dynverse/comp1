for tag in */ ; do
  echo $tag
  docker build ${tag::-1} -t dynverse/comp1:${tag::-1}
done

docker tag dynverse/comp1:R_text dynverse/comp1:latest
docker push dynverse/comp1