# roomba
This is a package to transform large, multi-nested lists into a more user-friendly format (i.e. a `tibble`) in `R`. The initial focus is on making processing of return values from `jsonlite::fromJSON()` queries more seamless, but ideally this package should be useful for deeply-nested lists from an array of sources. 

Key features of the package:
* `roomba(rows = , cols = )` searches deeply-nested list for names specified in `rows` or `cols` arguments (string vectors) and returns a `tibble` with the associated row or column titles. Nothing further about nesting hierarchy or depth need be specified.
* handling empty values gracefully - substituting with `NA` or user-specified value or truncating lists appropriately.

