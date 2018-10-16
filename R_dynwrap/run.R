library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(dynwrap)

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
  if(mean(pseudotime[data$start_id]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
model <- wrap_data(
  cell_ids = rownames(data$expression)
) %>% 
  add_linear_trajectory(
  pseudotime = pseudotime
)

write_rds(model, "/ti/output/output.rds")
