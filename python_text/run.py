import pandas as pd
import sklearn.decomposition
import json
import os

## Load data -----------------------------------------------
expression = pd.read_csv("/input/expression.csv", index_col=0)
params = json.load(open("/input/params.json", "r"))

if os.path.exists("/input/start_id.json"):
  start_id = json.load(open("/input/start_id.json"))
else:
  start_id = None


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

## Save output ---------------------------------------------
# output pseudotimes
pd.DataFrame({"cell_id": pseudotime.index, "pseudotime":pseudotime}).to_csv("/output/pseudotime.csv", index=False)
