#!/usr/bin/Rscript
library(tidyverse)

tags <- list.dirs(recursive = TRUE) %>% str_subset("\\./(R|python)_") %>% str_replace_all("^\\./", "")

for (tag in tags) {
  cat(tag, "\n", sep = "")

  babelwhale::convert_dockerfile_to_singularityrecipe(
    paste0(tag, "/Dockerfile"),
    paste0(tag, "/Singularity.", tag)
  )

  system(paste0("docker build ", tag, " -t dynverse/dynwrap_tester:", tag))
}



# system("docker push dynverse/dynwrap_tester")

# sudo singularity build python_feather.simg python_feather/Singularity.python_feather
# sudo singularity build python_hdf5.simg python_hdf5/Singularity.python_hdf5
# sudo singularity build python_text.simg python_text/Singularity.python_text
# sudo singularity build R_dynwrap.simg R_dynwrap/Singularity.R_dynwrap
# sudo singularity build R_feather.simg R_feather/Singularity.R_feather
# sudo singularity build R_hdf5.simg R_hdf5/Singularity.R_hdf5
# sudo singularity build R_rds.simg R_rds/Singularity.R_rds
# sudo singularity build R_text.simg R_text/Singularity.R_text
