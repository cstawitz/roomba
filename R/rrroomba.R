#' Roomba
#'
#' @description Tidy your nested list
#' @param inp List to tidy
#' @param replacement Replacement for NULL values. Defaults to NA.
#' @param cols Columns to keep
#' @param .keep Should all or any data be kept?
#'
#' @export
#'
#' @examples
#'
#' toy_data %>% roomba(cols = c("name", "goodstuff"), .keep = any)
#' toy_data %>% roomba(cols = c("name", "goodstuff", ""), .keep = any)


roomba <- function(inp, cols = NULL, .default = NA,
                    .keep = all) {
  assertthat::assert_that(length(inp) > 0,
                          msg = "Input is of length 0.")

  assertthat::assert_that(!is.null(cols),
                          msg = "cols must be non-NULL.")

  .keep <- match.fun(.keep)

  inp_clean <- inp %>%
    replace_null(replacement = .default)
  # -- Message that NULLs were replaced with NAs?

  has_good_stuff <- function(data, cols) {
    .keep(map_lgl(cols, ~ length(data[[.x]]) > 0))
  }

  indices <-
    dfs_idx(inp_clean, ~ has_good_stuff(data = .x, cols = cols))

  out <- indices %>%
    purrr:::map_dfr(
      function(.x) {
        res <- inp[[.x]]
        res[names(res) %in% cols]
      })

  return(out)
}



