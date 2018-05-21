# roomba
This is a package to transform large, multi-nested lists into a more user-friendly format (i.e. a `tibble`). The goal is to make processing
of returns from `jsonlite::fromJSON()` queries more seamless, but ideally this package should be useful for deeply-nested lists from an array 
of sources. 

Key freatures of the package:
* allow user specification of row and column structure of end object in a string vector, without needing to know the nesting hierarchy 
or depth.
* handling empty values gracefully - substituting with `NA` values or truncating lists appropriately.

