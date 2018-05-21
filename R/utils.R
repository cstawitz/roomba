replace_null <- function(x, replacement = NA_character_) {
  empty_idx <- dfs_idx(x, ~ length(.x) == 0)
  for (i in empty_idx) {
    x[[i]] <- replacement
  }
  x
}

#' vec <- list(c("a", "b"), x = NULL)
#' purrr::map(vec, replace_null, replacement = "foo")
