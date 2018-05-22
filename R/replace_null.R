#' Replace NULLs
#'
#' @description Replace all the empty values in a list
#' @param x list to use
#' @param replacement Replacement value for missing values
#' @examples
#' list(a = NULL, b = 1, c = list(foo = NULL, bar = NULL)) %>% replace_null()
#'
#' @export

replace_null <- function(x, replacement = NA) {
  empty_idx <- dfs_idx(x, ~ length(.x) == 0 || is.na(.x))
  for (i in empty_idx) {
    x[[i]] <- replacement
  }
  x
}
