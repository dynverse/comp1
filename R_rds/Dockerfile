# docker build R_rds -t dynverse/comp1:R_rds
FROM dynverse/dynwrap:r

ADD . /code

ENTRYPOINT Rscript /code/run.R
