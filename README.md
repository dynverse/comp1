# Creating TI methods within a docker

This repository contains a simple example of wrapping a TI method within a docker.

It contains three main files:

* `definition.yml` Defining the input, output and parameters of the method
* `Dockerfile` Used for building the docker, its entrypoint is used to run the method
* `run.R` Loads the data, infers a trajectory, and generates some output files

The docker image is automatically build at [dockerhub](https://hub.docker.com/r/dynverse/comp1/builds/).

This method can be run directly from dockerhub using

```r
library(dynwrap)
ti_comp1 <- pull_docker_ti_method("dynverse/comp1")
model <- infer_trajectory(task, ti_comp1)
```