FROM rocker/tidyverse
ADD . /code
RUN R -e "install.packages("ggplot2")"
ENTRYPOINT Rscript /code/run.R
