#' List all names in a list
#' @param x Input list
#' @export
list_names <- function(x) {
  name_idx <- dfs_idx(x, ~ length(names(.x)) > 0)
  unique(unlist(purrr::map(name_idx, ~ names(x[[.x]]))))
}

replace_null <- function(x, replacement = NA) {
  empty_idx <- dfs_idx(x, ~ length(.x) == 0)
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
