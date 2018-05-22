#' List all names in a list
#' @param x list to use
#' @export
list_names <- function(x) {
  name_idx <- dfs_idx(x, ~ length(names(.x)) > 0)
  unique(unlist(purrr::map(name_idx, ~ names(x[[.x]]))))
}


replace_single_null <- function(e, replacement = NA_character_) {
  if (length(e)) {
    return(e)
  } else {
    e <- replacement
    return(e)
  }
}
