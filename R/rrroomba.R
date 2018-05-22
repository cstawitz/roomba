#' Roomba
#'
#' @description Tidy your nested list
#' @param x Element to replace
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
                   cols = NULL) {
  assertthat::assert_that(length(inp) > 0,
                          msg = "Input is of length 0.")

  assertthat::assert_that(!is.null(cols),
                          msg = "cols must be non-NULL.")


  inp_clean <- inp %>%
    replace_null()
  # -- Message that NULLs were replaced with NAs?

  has_good_stuff <- function(x, y) {
    if (length(x[[y]]) > 0) {
      return(x[[y]])
    }
  }

  filter_cols <- function(x, y) {
    out <- map2(x, y, has_good_stuff)
    return(out)
  }

  inp_filtered <- inp_clean %>%
    dfs_idx(~ length(.x[[cols[1]]]) > 0)
    # dfs_idx(~ has_good_stuff(.x, cols[1]))

  out <- inp_filtered %>%
    purrr:::map_dfr(~ inp[[.x]])

  out <- out[, which(names(out) %in% cols)]

  # %>%
  #   select(!!!q_cols)

  return(out)
}

roomba(y, cols = c("name", "secret_power"))


roomba(y, cols = name)








