FROM dynverse/dynwrap:r

RUN R -e 'devtools::install_cran("feather")'

ADD . /code

ENTRYPOINT /code/run.sh
