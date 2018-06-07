library(dplyr, warn.conflicts = FALSE)
library(tibble, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(feather)

## Load data -----------------------------------------------

expression <- read_feather("/input/expression.feather") %>% 
  column_to_rownames("rownames") %>% 
  as.matrix()
if(file.exists("/input/start_cells.feather")) {
  start_cells <- read_feather("/input/start_cells.feather")$start_cells
} else {
  start_cells <- NULL
}

params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(expression)

# extract the component and use it as pseudotimes
pseudotime <- pca$x[, params$component]

# flip pseudotimes using start_cells
if (!is.null(start_cells)) {
  if(mean(pseudotime[start_cells]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
tibble::enframe(pseudotime, "cell_id", "pseudotime") %>% 
  write_feather("/output/pseudotime.feather")