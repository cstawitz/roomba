#' roomba package
#'
#' \tabular{ll}{
#' Package: \tab roomba\cr
#' Type: \tab Package\cr
#' }
#'
#' Collection of functions to do deal with deeply nested data
#'
#' @name roomba-package
#' @docType package
NULL

#' Example Twitter data
#'
#' Example data from Twitter API
#'
#' @name twitter_data
#' @rdname example_data
#' @docType data
#' @keywords twitter data
#' @examples
#' twitter_data[[1]][["id"]]
NULL





#' Roomba
#'
#' @description Tidy your nested list
#' @param inp Element to replace
#' @param clean Should NULL values be changed to NAs?
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
#'
#'


roomba <- function(inp, replacement = NA_character_,
                   rows = NULL, cols = NULL) {
  assertthat::assert_that(length(inp),
                          "Input is of length 0.")

  assertthat::assert_that(!is.null(rows) && !is.null(cols),
                          "rows and cols must both be non-NULL.")

  if (clean == TRUE) {
    assertthat::assert_that(!is.null(replacement),
                            "If clean is TRUE, a non-NULL replacement must be provided.")
  }


}

