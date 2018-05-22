context("roomba utility function tests")


test_that("Test that replace_null() works as expected", {
  lst <- list(c("a", "b"), x = NULL)
  cleaned_lst <- roomba:::replace_null(lst,
                            replacement = "foo")

  testthat::expect_equal(cleaned_lst,
                         list(c("a", "b"), x = "foo"))

})
