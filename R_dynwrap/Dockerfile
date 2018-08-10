# docker build R_dynwrap -t dynverse/comp1:R_dynwrap
FROM dynverse/dynwrap:r

ADD . /code

ENTRYPOINT Rscript /code/run.R
