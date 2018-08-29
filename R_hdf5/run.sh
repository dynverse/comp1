#!/usr/local/bin/Rscript

library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(hdf5r)

## Load data -----------------------------------------------
file <- H5File$new("/ti/input/data.h5", "r")
expression <- file[["expression"]][,]
rownames(expression) <- file[["expression_rows"]][]
if(file$exists("start_id")) {
  start_id <- file[["start_id"]][]
} else {
  start_id <- NULL
}
file$close()

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
tibble::tibble(cell_ids = names(pseudotime)) %>%
  write_csv("/ti/output/cell_ids.csv")
tibble::enframe(pseudotime, "cell_id", "pseudotime") %>% 
  write_csv("/ti/output/pseudotime.csv")
