# docker build python_feather -t dynverse/comp1:python_feather
FROM dynverse/dynwrap:py3.6

RUN pip install sklearn

RUN pip install Cython feather-format

ADD . /code

ENTRYPOINT /code/run.sh
