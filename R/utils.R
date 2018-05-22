replace_null <- function(x, replacement = NA) {
  empty_idx <- dfs_idx(x, ~ length(.x) == 0 || is.na(.x))
  for (i in empty_idx) {
    x[[i]] <- replacement
  }
  x
}

replace_single_null <- function(e, replacement = NA_character_) {
  if (length(e)) {
    return(e)
  } else {
    e <- replacement
    return(e)
  }
}
