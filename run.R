library(tidyverse)

## Load data -----------------------------------------------

expression <- read.csv("/input/expression.csv", row.names=1, header = TRUE) %>%
  as.matrix()
params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)
start_cells <- jsonlite::read_json("/input/start_cells.json", simplifyVector = TRUE)

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(expression)

# extract the component and use it as pseudotimes
pseudotimes <- pca$x[, params$component]

# flip pseudotimes using start_cells
if (!is.null(start_cells)) {
  if(mean(pseudotimes[start_cells]) > 0.5) {
    pseudotimes <- 1-pseudotimes
  }
}

## Save output ---------------------------------------------
# output pseudotimes
tibble(
  cell_id = names(pseudotimes),
  pseudotime = pseudotimes
) %>%
  write_csv("/output/pseudotimes.csv")
