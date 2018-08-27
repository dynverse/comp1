FROM dynverse/dynwrap:py3.6

RUN pip install sklearn

RUN pip install h5py tables

ADD . /code

ENTRYPOINT /code/run.sh
