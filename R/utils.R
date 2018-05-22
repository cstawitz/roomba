#' List all names in a list
#' @param x list to use
#' @export
list_names <- function(x) {
  name_idx <- dfs_idx(x, ~ length(names(.x)) > 0)
  unique(unlist(purrr::map(name_idx, ~ names(x[[.x]]))))
}

#' @param x list to use
#' @export
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
