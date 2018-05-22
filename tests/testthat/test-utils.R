context("roomba utility function tests")

library(purrr)
library(dplyr)

test_that("Test that replace_null() works as expected", {
  # Test that replace_null() works as expected
  lst <- list(c("a", "b"), x = NULL)
  cleaned_lst <- roomba:::replace_null(lst, replacement = "foo")
  expect_equal(cleaned_lst,
               list(c("a", "b"), x = "foo"))
})

test_that("Test that replace_null() works with numbers", {
  # Test that replace_null() works as expected

  toy_data <- jsonlite::fromJSON('
  {
                                 "stuff": {
                                 "buried": {
                                 "deep": [
                                 {
                                 "goodstuff": "here",
                                 "secret_power": 5,
                                 "other_secret_power": []
                                 },
                                 {
                                 "goodstuff": "here",
                                 "name": "Amanda Dobbyn",
                                 "more_nested_stuff": 4
                                 }
                                 ],
                                 "alsodeep": 2342423234,
                                 "deeper": {
                                 "foo": [
                                 {
                                 "goodstuff": "not here",
                                 "name": "barb",
                                 "secret_power": []
                                 },
                                 {
                                 "goodstuff": "here",    // More deeply nested "goodstuff" than "goodstuff"s above
                                 "name": "borris"
                                 }
                                 ]
                                 }
                                 }
                                 }
}', simplifyVector = FALSE)


  cleaned_lst <- roomba:::replace_null(toy_data)

  secret_power <- cleaned_lst %>% dfs_idx(~ .x$goodstuff == "here") %>%
    purrr:::map_dfr(~ cleaned_lst[[.x]]) %>%
    dplyr::pull(secret_power)

  expect_type(secret_power, "integer")

  toy_names <- cleaned_lst %>% dfs_idx(~ .x$goodstuff == "here") %>%
    purrr:::map_dfr(~ cleaned_lst[[.x]]) %>%
    dplyr::pull(name)

  expect_type(toy_names, "character")

})
