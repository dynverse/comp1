docker build python_hdf5 -t dynverse/comp1:python_hdf5
docker build python_text -t dynverse/comp1:python_text
docker build R_text -t dynverse/comp1:R_text
docker build R_hdf5 -t dynverse/comp1:R_hdf5
docker build R_dynwrap -t dynverse/comp1:R_dynwrap
docker build R_rds -t dynverse/comp1:R_rds
docker build R_dynwrap -t dynverse/comp1:latest

docker push dynverse/comp1
