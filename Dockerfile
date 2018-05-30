FROM rocker/tidyverse
ADD . /code
# RUN R -e "install.packages(...)" # install R dependencies
ENTRYPOINT Rscript /code/run.R
