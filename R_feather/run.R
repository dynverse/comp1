library(dplyr, warn.conflicts = FALSE)
library(tibble, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(feather)

## Load data -----------------------------------------------

expression <- read_feather("/ti/input/expression.feather") %>% 
  column_to_rownames("rownames") %>% 
  as.matrix()
if(file.exists("/ti/input/start_id.feather")) {
  start_id <- read_feather("/ti/input/start_id.feather")$start_id
} else {
  start_id <- NULL
}

params <- jsonlite::read_json("/ti/input/params.json", simplifyVector = TRUE)

## Trajectory inference -----------------------------------
# do PCA
pca <- prcomp(expression)

# extract the component and use it as pseudotimes
pseudotime <- pca$x[, params$component]

# flip pseudotimes using start_id
if (!is.null(start_id)) {
  if(mean(pseudotime[start_id]) > 0.5) {
    pseudotime <- 1-pseudotime
  }
}

## Save output ---------------------------------------------
# output pseudotimes
tibble::tibble(cell_ids = names(pseudotime)) %>% 
  write_feather("/ti/output/cell_ids.feather")
tibble::enframe(pseudotime, "cell_id", "pseudotime") %>% 
  write_feather("/ti/output/pseudotime.feather")
