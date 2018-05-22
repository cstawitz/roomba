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

  assertthat::assert_that(!is.null(deparse(substitute(cols))),
                          msg = "cols must be non-NULL.")


  inp_clean <- inp %>%
    replace_null()
  # -- Message that NULLs were replaced with NAs?

  has_good_stuff <- function(x, y) {
    y <- enquo(y)
    if (length(x %>% select(!!y)) > 0) {
      return(x %>% select(!!y))
    }
  }

  filter_cols <- function(x, y) {
    out <- map2(x, y, has_good_stuff)
    return(out)
  }

  q_first_col <- enquo(cols[1])

  inp_filtered <- inp_clean %>%
    dfs_idx(~ length(.x %>% select(!!q_first_col)) > 0)
    # dfs_idx(~ length(.x[[cols[1]]]) > 0)
    # dfs_idx(~ has_good_stuff(.x, cols[1]))



  out <- inp_filtered %>%
    purrr:::map_dfr(~ inp[[.x]])

  out <- out[, which(names(out) %in% cols)]

  # %>%
  #   select(!!!q_cols)

  return(out)
}

roomba(y, cols = name)

roomba(y, cols = c("name", "secret_power"))








