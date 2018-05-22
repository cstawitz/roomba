#' List all names in a list
#' @export
list_names <- function(x, replacement = NA) {
  name_idx <- dfs_idx(x, ~ length(names(.x)) > 0)
  unique(unlist(map(name_idx, ~ names(x[[.x]]))))
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

#' vec <- list(c("a", "b"), x = NULL)
#' purrr::map(vec, replace_null, replacement = "foo")



has_good_stuff <- function(x, y) {
  if (length(x[[y]]) > 0) {
    return(x[[y]])
  }
}
