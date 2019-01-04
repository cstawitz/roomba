context("roomba tests")

library(jsonlite)

test_that("Test that roomba() works as expected", {

  some_json <- '{
                 "foo": [{"a": 1, "b": 2, "c": 3}],
                 "bar": [{"a": 4, "c": 6, "b": null}],
                 "baz": [],
                 "bing":[{"c": 12}]
                }'

  lst <- fromJSON(some_json)

  expect_equal(roomba(lst, cols = c("a", "b", "c")),
               data.frame(a = c(1, 4), b = c(2, NA), c = c(3, 6)))

  expect_equal(roomba(lst, cols = c("a", "b", "c"), keep = any),
               data.frame(a = c(1, 4, NA), b = c(2, NA, NA), c = c(3, 6, 12)))

  expect_error(roomba(lst, cols = character()),
               regexp = "Argument 1 must have names")

  expect_error(roomba(lst),
               regexp = "cols must be non-NULL.")

})
