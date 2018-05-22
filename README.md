
# roomba

[![Travis build
status](https://travis-ci.com/ropenscilabs/roomba.svg?branch=master)](https://travis-ci.com/ropenscilabs/roomba)

This is a package to transform large, multi-nested lists into a more
user-friendly format (i.e. a `tibble`) in `R`. The initial focus is on
making processing of return values from `jsonlite::fromJSON()` queries
more seamless, but ideally this package should be useful for
deeply-nested lists from an array of sources.

Key features of the package: \* `roomba(rows = , cols = )` searches
deeply-nested list for names specified in `rows` or `cols` arguments
(string vectors) and returns a `tibble` with the associated row or
column titles. Nothing further about nesting hierarchy or depth need be
specified. \* handles empty values gracefully via `replace_nulls()`
function that substitutes `NULL` values with `NA` or user-specified
value, or truncates lists appropriately. The goal of roomba is to tidy
recursive lists.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/roomba")
```

## Example

``` r
library(roomba)

toy_data <- jsonlite::fromJSON('
  {
    "stuff": {
      "buried": {
        "deep": [
        {
          "goodstuff": "here",
          "name": "Bob Rudis",
          "secret_power": 5,
          "other_secret_power": []
        },
        {
          "goodstuff": "here",
          "name": "Amanda Dobbyn",
          "secret_power": 4, 
          "more_nested_stuff": 4
        }
        ],
        "alsodeep": 2342423234,
        "deeper": {
          "foo": [
          {
            "goodstuff": 5,
            "name": "barb",
            "secret_power": []
          },
          {
             "goodstuff": "here",
             "name": "borris"
          }
            ]
        }
      }
    }
  }', simplifyVector = FALSE)


# Replace the NULLs at every level with the default replacement, NA
y <- toy_data %>% replace_null() 
y
#> $stuff
#> $stuff$buried
#> $stuff$buried$deep
#> $stuff$buried$deep[[1]]
#> $stuff$buried$deep[[1]]$goodstuff
#> [1] "here"
#> 
#> $stuff$buried$deep[[1]]$name
#> [1] "Bob Rudis"
#> 
#> $stuff$buried$deep[[1]]$secret_power
#> [1] 5
#> 
#> $stuff$buried$deep[[1]]$other_secret_power
#> [1] NA
#> 
#> 
#> $stuff$buried$deep[[2]]
#> $stuff$buried$deep[[2]]$goodstuff
#> [1] "here"
#> 
#> $stuff$buried$deep[[2]]$name
#> [1] "Amanda Dobbyn"
#> 
#> $stuff$buried$deep[[2]]$secret_power
#> [1] 4
#> 
#> $stuff$buried$deep[[2]]$more_nested_stuff
#> [1] 4
#> 
#> 
#> 
#> $stuff$buried$alsodeep
#> [1] 2342423234
#> 
#> $stuff$buried$deeper
#> $stuff$buried$deeper$foo
#> $stuff$buried$deeper$foo[[1]]
#> $stuff$buried$deeper$foo[[1]]$goodstuff
#> [1] 5
#> 
#> $stuff$buried$deeper$foo[[1]]$name
#> [1] "barb"
#> 
#> $stuff$buried$deeper$foo[[1]]$secret_power
#> [1] NA
#> 
#> 
#> $stuff$buried$deeper$foo[[2]]
#> $stuff$buried$deeper$foo[[2]]$goodstuff
#> [1] "here"
#> 
#> $stuff$buried$deeper$foo[[2]]$name
#> [1] "borris"

y %>% dfs_idx(~ .x$goodstuff == "here") %>%
  purrr:::map_dfr(~ y[[.x]])
#> # A tibble: 3 x 5
#>   goodstuff name          secret_power other_secret_power more_nested_stu…
#>   <chr>     <chr>                <int> <chr>                         <int>
#> 1 here      Bob Rudis                5 <NA>                             NA
#> 2 here      Amanda Dobbyn            4 <NA>                              4
#> 3 here      borris                  NA <NA>                             NA
```
