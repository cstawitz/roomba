
replace_null <- function(e, replacement = NA_character_) {
  if (length(e)) {
    return(e)
  } else {
    e <- replacement
    return(e)
  }
}

#' vec <- list(c("a", "b"), x = NULL)
#' purrr::map(vec, replace_null, replacement = "foo")
