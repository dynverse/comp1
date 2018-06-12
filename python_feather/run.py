import pandas as pd
import sklearn.decomposition
import json
import os
import feather

## Load data -----------------------------------------------

expression = pd.read_feather("/input/expression.feather").set_index("rownames")
params = json.load(open("/input/params.json", "r"))

if os.path.exists("/input/start_id.feather"):
  start_id = pd.read_feather("/input/start_id.feather").start_id
else:
  start_id = None


## Trajectory inference -----------------------------------
# do PCA
pca = sklearn.decomposition.PCA()
x = pca.fit_transform(expression)

# extract the component and use it as pseudotimes
pseudotime = pd.DataFrame({
  "pseudotime":x[:, params["component"]], 
  "cell_id":expression.index
})

# flip pseudotimes using start_id
if start_id is not None:
  if pseudotime.pseudotime[start_id].mean():
    pseudotime.pseudotime = 1 - pseudotime.pseudotime

## Save output ---------------------------------------------
# output pseudotimes
pseudotime.to_feather("/output/pseudotime.feather")
