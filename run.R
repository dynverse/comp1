library(dplyr, warn.conflicts = FALSE)

## Load data -----------------------------------------------

expression <- read.csv("/input/expression.csv", row.names=1, header = TRUE) %>%
  as.matrix()
params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)

if (file.exists("/input/prior_information.json")) {
  priors <- jsonlite::read_json("/input/prior_information.json", simplifyVector = TRUE)
} else {
  priors <- list()
}

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(expression)

# extract the component and use it as pseudotimes
pseudotime <- pca$x[, params$component]

# flip pseudotimes using start_cells
if (!is.null(priors$start_cells)) {
  if(mean(pseudotime[priors$start_cells]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
tibble(
  cell_id = names(pseudotime),
  pseudotime = pseudotime
) %>%
  write_csv("/output/pseudotime.csv")
