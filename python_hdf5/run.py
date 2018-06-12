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
pseudotime = pd.Series(x[:, params["component"]], index=expression.index)

# flip pseudotimes using start_id
if start_id is not None:
  if pseudotime[start_id].mean():
    pseudotime = 1 - pseudotime
# 
# ## Save output ---------------------------------------------
# # output pseudotimes
# output pseudotimes
pd.DataFrame({"cell_id": pseudotime.index, "pseudotime":pseudotime}).to_csv("/output/pseudotime.csv", index=False)
