context("roomba utility function tests")

# Test that replace_null() works as expected
lst <- list(c("a", "b"), x = NULL)
cleaned_lst <- purrr::map(vec, replace_null, replacement = "foo")
testthat::expect_equal(cleaned_lst,
                       list(c("a", "b"), x = "foo"))

