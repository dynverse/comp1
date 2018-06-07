import pandas as pd
import sklearn.decomposition
import json
import os
import feather

## Load data -----------------------------------------------

expression = pd.read_feather("input/expression.feather").set_index("rownames")
params = json.load(open("input/params.json", "r"))

if os.path.exists("input/start_cells.feather"):
  start_cells = pd.read_feather("input/start_cells.feather").start_cells
else:
  start_cells = None


## Trajectory inference -----------------------------------
# do PCA
pca = sklearn.decomposition.PCA()
x = pca.fit_transform(expression)

# extract the component and use it as pseudotimes
pseudotime = pd.DataFrame({
  "pseudotime":x[:, params["component"]], 
  "cell_id":expression.index
})

# flip pseudotimes using start_cells
if start_cells is not None:
  if pseudotime.pseudotime[start_cells].mean():
    pseudotime.pseudotime = 1 - pseudotime.pseudotime

## Save output ---------------------------------------------
# output pseudotimes
pseudotime.to_feather("/output/pseudotime.feather")
