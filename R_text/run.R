library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

## Load data -----------------------------------------------

expression <- read.csv("/input/expression.csv", row.names=1, header = TRUE) %>%
  as.matrix()
params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)

if (file.exists("/input/start_id.json")) {
  start_id <- jsonlite::read_json("/input/start_id.json", simplifyVector = TRUE)
} else {
  start_id <- NULL
}

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
tibble::enframe(pseudotime, "cell_id", "pseudotime") %>% 
  write_csv("/output/pseudotime.csv")