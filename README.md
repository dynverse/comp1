# Creating TI methods within a docker

This repository contains a simple example of wrapping a TI method within a docker.



The docker image is automatically build at [dockerhub](https://hub.docker.com/r/dynverse/comp1/builds/).

This method can be run using

```r
ti_comp1 <- dynmethods::create_docker_ti_method("dynverse/comp1")
```