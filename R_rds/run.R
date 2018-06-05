library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

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
  if(mean(pseudotime[priors$start_cells]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
output <- list(
  pseudotime = tibble(
    cell_id = names(pseudotime),
    pseudotime = pseudotime
  )
)

write_rds(output, "/output/output.rds")