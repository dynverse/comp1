# docker build R_dynwrap -t dynverse/comp1:R_dynwrap
FROM rocker/tidyverse
RUN R -e 'devtools::install_github("dynverse/dynwrap")'
ADD . /code
ENTRYPOINT Rscript /code/run.R
