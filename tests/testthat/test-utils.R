context("roomba utility function tests")

test_that("Test that replace_null() works as expected", {
  # Test that replace_null() works as expected
  lst <- list(c("a", "b"), x = NULL)
  cleaned_lst <- replace_null(lst, replacement = "foo")
  expect_equal(cleaned_lst,
               list(c("a", "b"), x = "foo"))
})
