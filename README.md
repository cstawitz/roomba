
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
          "location": "here",
          "name": "Bob Rudis",
          "super_power": "invisibility",
          "other_secret_power": []
        },
        {
          "location": "here",
          "name": "Amanda Dobbyn",
          "secret_power": "flight",
          "more_nested_stuff": 4
        }
        ],
        "alsodeep": 2342423234,
        "deeper": {
          "foo": [
          {
            "location": "not here",
            "name": "Jim Hester",
            "secret_power": []
          },
          {
             "location": "here",
             "name": "Borris"
          }
          ]
        }
      }
    }
  }', simplifyVector = FALSE)

toy_data %>%
  roomba(cols = c("name", "location", "secret_power", "other_secret_power"), keep = any)
#> # A tibble: 4 x 4
#>   location name          other_secret_power secret_power
#>   <chr>    <chr>         <lgl>              <chr>       
#> 1 here     Bob Rudis     NA                 <NA>        
#> 2 here     Amanda Dobbyn NA                 flight      
#> 3 not here Jim Hester    NA                 <NA>        
#> 4 here     Borris        NA                 <NA>
```
