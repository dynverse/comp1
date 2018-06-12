# docker build R_text -t dynverse/comp1:R_text
# docker push dynverse/comp1:R_text
FROM rocker/tidyverse
ADD . /code
LABEL 
ENTRYPOINT Rscript /code/run.R
