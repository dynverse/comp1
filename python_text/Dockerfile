# docker build python_text -t dynverse/comp1:python_text
FROM dynverse/dynwrap:py3.6

RUN pip install sklearn

ADD . /code

ENTRYPOINT python /code/run.py
