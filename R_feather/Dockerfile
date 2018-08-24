# docker build R_feather -t dynverse/comp1:R_feather
FROM dynverse/dynwrap:r

RUN R -e 'install.packages("feather")'

ADD . /code

ENTRYPOINT /code/run.sh
