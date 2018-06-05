# docker build python_hdf5 -t dynverse/comp1:python_hdf5
FROM library/python
RUN pip install scipy numpy pandas sklearn
RUN pip install h5py tables
ADD . /code
ENTRYPOINT python /code/run.py
