library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(dynwrap)

## Load data -----------------------------------------------

data <- read_rds("/input/data.rds")
params <- read_rds("input/params.rds")

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(data$expression)

# extract the component and use it as pseudotimes
pseudotime <- pca$x[, params$component]

# flip pseudotimes using start_cells
if (!is.null(data$start_cells)) {
  if(mean(pseudotime[data$start_cells]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
model <- dynwrap::wrap_data(cell_ids = rownames(data$expression)) %>% 
  add_linear_trajectory(pseudotime)

write_rds(model, "/output/output.rds")