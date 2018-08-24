#!/usr/bin/Rscript

library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

## Load data -----------------------------------------------

data <- read_rds("/ti/input/data.rds")
params <- jsonlite::read_json("/ti/input/params.json", simplifyVector = TRUE)

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(data$expression)

# extract the component and use it as pseudotimes
pseudotime <- pca$x[, params$component]

# flip pseudotimes using start_id
if (!is.null(data$start_id)) {
  if(mean(pseudotime[priors$start_id]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
output <- list(
  cell_ids = names(pseudotime),
  pseudotime = tibble(
    cell_id = names(pseudotime),
    pseudotime = pseudotime
  )
)

write_rds(output, "/ti/output/output.rds")
