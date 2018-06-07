library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

## Load data -----------------------------------------------

expression <- read.csv("/input/expression.csv", row.names=1, header = TRUE) %>%
  as.matrix()
params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)

if (file.exists("/input/start_cells.json")) {
  start_cells <- jsonlite::read_json("/input/start_cells.json", simplifyVector = TRUE)
} else {
  start_cells <- NULL
}

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
tibble::enframe(pseudotime, "cell_id", "pseudotime") %>% 
  write_csv("/output/pseudotime.csv")