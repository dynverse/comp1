FROM dynverse/dynwrap:r

RUN apt-get -y install libhdf5-dev

RUN R -e "devtools::install_cran('hdf5r')"

ADD . /code

ENTRYPOINT /code/run.sh
