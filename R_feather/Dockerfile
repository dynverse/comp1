# docker build R_feather -t dynverse/comp1:R_feather
FROM rocker/tidyverse
RUN R -e 'install.packages("feather")'
ADD . /code
ENTRYPOINT Rscript /code/run.R
