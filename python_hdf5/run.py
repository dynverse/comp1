import pandas as pd
import sklearn.decomposition
import numpy as np
import h5py
import json

## Load data -----------------------------------------------
data = h5py.File("/input/data.h5", "r")
expression = pd.DataFrame(data['expression'][:].T, index=data['expression'].attrs['rownames'].astype(np.str))
if "start_id" in data:
  start_id = data['start_id']
else:
  start_id = None
data.close()

params = json.load(open("/input/params.json", "r"))


## Trajectory inference -----------------------------------
# do PCA
pca = sklearn.decomposition.PCA()
x = pca.fit_transform(expression)

# extract the component and use it as pseudotimes
cell_ids = pd.DataFrame({
  "cell_ids":expression.index
})
pseudotime = pd.DataFrame({
  "pseudotime":x[:, params["component"]], 
  "cell_id":expression.index
})

# flip pseudotimes using start_id
if start_id is not None:
  if pseudotime.pseudotime[start_id].mean():
    pseudotime.pseudotime = 1 - pseudotime.pseudotime
# 
# ## Save output ---------------------------------------------
# # output pseudotimes
# output pseudotimes
cell_ids.to_csv("/output/cell_ids.csv")
pseudotime.to_csv("/output/pseudotime.csv")
