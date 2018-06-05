# docker build python_text -t dynverse/comp1:python_text
FROM library/python
RUN pip install scipy numpy pandas sklearn
ADD . /code
ENTRYPOINT python /code/run.py
