#' Roomba
#'
#' @description Tidy your nested list
#' @param replacement Replacement for NULL values. Defaults to NA_character_.
#' @param inp Element to replace
#' @param replacement Replacement for NULL values. Defaults to NA_character_.
#' @param rows
#' @param cols
#'
#' @export
#'
#' @examples
#'
#'
#'


roomba <- function(inp, replacement = NA,
                   cols = NULL, .keep = all) {
  assertthat::assert_that(length(inp) > 0,
                          msg = "Input is of length 0.")

  assertthat::assert_that(!is.null(cols),
                          msg = "cols must be non-NULL.")

  .keep <- match.fun(.keep)

  inp_clean <- inp %>%
    replace_null()
  # -- Message that NULLs were replaced with NAs?


  has_good_stuff <- function(data, cols) {
    .keep(map_lgl(cols, ~ length(data[[.x]]) > 0))
  }

  inp_filtered <-
    dfs_idx(inp_clean, ~ has_good_stuff(data = .x, cols = cols))

  out <- inp_filtered %>%
    purrr:::map_dfr(
      function(.x) {
        res <- inp[[.x]]
        res[names(res) %in% cols]
      })

  return(out)
}

roomba(y, cols = c("name", "secret_power"), .keep = any)

roomba(y, cols = c("name", "secret_power", "goodstuff"), .keep = all)









