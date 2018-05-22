context("roomba indexing tests")

test_that("", {

  twitter_data <- twitter_data
  x <- dfs_idx(twitter_data, ~ .x$id_str == "998623997397876743")
  expect_length(x, 1)
})
