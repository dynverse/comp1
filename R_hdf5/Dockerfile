# docker build R_hdf5 -t dynverse/comp1:R_hdf5
FROM dynverse/dynwrap:r

RUN apt-get -y install libhdf5-dev

RUN R -e "install.packages('hdf5r')"

ADD . /code

ENTRYPOINT /code/run.sh
