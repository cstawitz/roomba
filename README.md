# roomba
This is a package to transform large, multi-nested lists into a more user-friendly format (i.e. a `tibble`) in `R`. The initial focus is on making processing of return values from `jsonlite::fromJSON()` queries more seamless, but ideally this package should be useful for deeply-nested lists from an array of sources. 

Key features of the package:
* allow user specification of row and column structure of output `tibble` in string vector arguments, without needing to know the nesting hierarchy or depth.
* handling empty values gracefully - substituting with `NA` or user-specified value or truncating lists appropriately.

