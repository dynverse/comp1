import pandas as pd
import sklearn.decomposition
import json
import os

## Load data -----------------------------------------------
expression = pd.read_csv("/input/expression.csv", index_col=0)
params = json.load(open("input/params.json", "r"))

if os.path.exists("input/start_cells.json"):
  start_cells = json.load(open("input/start_cells.json"))
else:
  start_cells = None


## Trajectory inference -----------------------------------
# do PCA
pca = sklearn.decomposition.PCA()
x = pca.fit_transform(expression)

# extract the component and use it as pseudotimes
pseudotime = pd.Series(x[:, params["component"][0]], index=expression.index)

# flip pseudotimes using start_cells
if start_cells is not None:
  if pseudotime[start_cells].mean():
    pseudotime = 1 - pseudotime

## Save output ---------------------------------------------
# output pseudotimes
pd.DataFrame({"cell_id": pseudotime.index, "pseudotime":pseudotime}).to_csv("/output/pseudotime.csv", index=False)
