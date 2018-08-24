#!/usr/bin/python

import pandas as pd
import sklearn.decomposition
import json
import os

## Load data -----------------------------------------------
expression = pd.read_csv("/ti/input/expression.csv", index_col=0)
params = json.load(open("/ti/input/params.json", "r"))

if os.path.exists("/ti/input/start_id.json"):
  start_id = json.load(open("/ti/input/start_id.json"))
else:
  start_id = None


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
cell_ids.to_csv("/ti/output/cell_ids.csv", index = False)
pseudotime.to_csv("/ti/output/pseudotime.csv", index = False)
