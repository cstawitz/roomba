#' Perform a recursive depth first search of a function
#' @inheritParams purrr::map
#' @export
dfs_idx <- function(.x, .f) {
  .f <- purrr::as_mapper(.f)
  .x <- .x %>% replace_null()
  res <- list()
  num <- 0L
  walk <- function(x, idx) {
    for (i in seq_along(x)) {
      if (isTRUE(tryCatch(.f(x[[i]]), error = function(e) FALSE))) {
        res[[num <<- num + 1L]] <<- append(idx, i)
      }
      if (is.list(x[[i]])) {
        walk(x[[i]], append(idx, i))
      }
    }
  }
  walk(.x, integer())
  res
}
