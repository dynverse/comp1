# docker build python_feather -t dynverse/comp1:python_feather
FROM library/python
RUN pip install scipy numpy pandas sklearn
RUN pip install feather-format
ADD . /code
ENTRYPOINT python /code/run.py
