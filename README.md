
roomba
======

[![Travis build status](https://travis-ci.com/ropenscilabs/roomba.svg?branch=master)](https://travis-ci.com/ropenscilabs/roomba)

This is a package to transform large, multi-nested lists into a more user-friendly format (i.e. a `tibble`) in `R`. The initial focus is on making processing of return values from `jsonlite::fromJSON()` queries more seamless, but ideally this package should be useful for deeply-nested lists from an array of sources.

*Key features:*

-   `roomba()` searches deeply-nested list for names specified in `cols` (a character vector) and returns a `tibble` with the associated column titles. Nothing further about nesting hierarchy or depth need be specified.

-   Handles empty values gracefully by substituting `NULL` values with `NA` or user-specified value in `.default`, or truncates lists appropriately.

-   Option to `.keep` `any` or `all` data from the columns supplied

Installation
------------

You can install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/roomba")
```

Example
-------

Say we have some JSON from a pesky API.

``` r
library(roomba)

json <- '
  {
    "stuff": {
      "buried": {
        "deep": [
        {
          "location": "here",
          "name": "Amanda",
          "super_power": "flight",
          "more_nested_stuff": 4
        },
        {
          "location": "here",
          "name": "Christine",
          "super_power": "water-breathing"
        },
        {
          "location": "here",
          "name": "Isabella",
          "super_power": "teleportation"
        }
        ],
        "alsodeep": 2342423234,
        "deeper": {
          "foo": [
          {
            "location": "not here",
            "name": "Jim"
          },
          {
            "location": "here",
            "name": "Isabella Velasquez",
            "secret_power": "shape-shifting"
          },
          {
            "location": "here",
            "name": "Christine Stawitz",
            "secret_power": "shape-shifting"
          },
          {
             "location": "here",
             "name": "Laura",
             "super_power": "git"
          }
          ]
        }
      }
    }
  }'
```

The JSON becomes a nested R list

``` r
super_data <- json %>% 
  jsonlite::fromJSON(simplifyVector = FALSE)
```

Which we can pull data into the columns we want with `roomba`.

``` r
super_data %>%
  roomba(cols = c("name", "super_power", "location"), keep = any)
#> # A tibble: 7 x 3
#>   location name               super_power    
#>   <chr>    <chr>              <chr>          
#> 1 here     Amanda             flight         
#> 2 here     Christine          water-breathing
#> 3 here     Isabella           teleportation  
#> 4 not here Jim                <NA>           
#> 5 here     Isabella Velasquez <NA>           
#> 6 here     Christine Stawitz  <NA>           
#> 7 here     Laura              git
```

Twitter Example
---------------

Let's try with a real-world Twitter example.

``` r
twitter_data[[1]]
#> $created_at
#> [1] "Mon May 21 17:58:09 +0000 2018"
#> 
#> $id
#> [1] 9.98624e+17
#> 
#> $id_str
#> [1] "998623997397876743"
#> 
#> $text
#> [1] "Could a program like food stamps have a Cambridge Analytica moment? How do we allow for the innovation that data pl… https://t.co/7tVf1qmNmq"
#> 
#> $truncated
#> [1] TRUE
#> 
#> $entities
#> $entities$hashtags
#> list()
#> 
#> $entities$symbols
#> list()
#> 
#> $entities$user_mentions
#> list()
#> 
#> $entities$urls
#> $entities$urls[[1]]
#> $entities$urls[[1]]$url
#> [1] "https://t.co/7tVf1qmNmq"
#> 
#> $entities$urls[[1]]$expanded_url
#> [1] "https://twitter.com/i/web/status/998623997397876743"
#> 
#> $entities$urls[[1]]$display_url
#> [1] "twitter.com/i/web/status/9…"
#> 
#> $entities$urls[[1]]$indices
#> $entities$urls[[1]]$indices[[1]]
#> [1] 117
#> 
#> $entities$urls[[1]]$indices[[2]]
#> [1] 140
#> 
#> 
#> 
#> 
#> 
#> $source
#> [1] "<a href=\"https://about.twitter.com/products/tweetdeck\" rel=\"nofollow\">TweetDeck</a>"
#> 
#> $in_reply_to_status_id
#> NULL
#> 
#> $in_reply_to_status_id_str
#> NULL
#> 
#> $in_reply_to_user_id
#> NULL
#> 
#> $in_reply_to_user_id_str
#> NULL
#> 
#> $in_reply_to_screen_name
#> NULL
#> 
#> $user
#> $user$id
#> [1] 64482503
#> 
#> $user$id_str
#> [1] "64482503"
#> 
#> $user$name
#> [1] "Code for America"
#> 
#> $user$screen_name
#> [1] "codeforamerica"
#> 
#> $user$location
#> [1] "San Francisco, California"
#> 
#> $user$description
#> [1] "Government can work for the people, by the people, in the 21st century. Help us make it so."
#> 
#> $user$url
#> [1] "https://t.co/l9lokka0rJ"
#> 
#> $user$entities
#> $user$entities$url
#> $user$entities$url$urls
#> $user$entities$url$urls[[1]]
#> $user$entities$url$urls[[1]]$url
#> [1] "https://t.co/l9lokka0rJ"
#> 
#> $user$entities$url$urls[[1]]$expanded_url
#> [1] "http://codeforamerica.org"
#> 
#> $user$entities$url$urls[[1]]$display_url
#> [1] "codeforamerica.org"
#> 
#> $user$entities$url$urls[[1]]$indices
#> $user$entities$url$urls[[1]]$indices[[1]]
#> [1] 0
#> 
#> $user$entities$url$urls[[1]]$indices[[2]]
#> [1] 23
#> 
#> 
#> 
#> 
#> 
#> $user$entities$description
#> $user$entities$description$urls
#> list()
#> 
#> 
#> 
#> $user$protected
#> [1] FALSE
#> 
#> $user$followers_count
#> [1] 49202
#> 
#> $user$friends_count
#> [1] 1716
#> 
#> $user$listed_count
#> [1] 2659
#> 
#> $user$created_at
#> [1] "Mon Aug 10 18:59:29 +0000 2009"
#> 
#> $user$favourites_count
#> [1] 4490
#> 
#> $user$utc_offset
#> [1] -25200
#> 
#> $user$time_zone
#> [1] "Pacific Time (US & Canada)"
#> 
#> $user$geo_enabled
#> [1] TRUE
#> 
#> $user$verified
#> [1] TRUE
#> 
#> $user$statuses_count
#> [1] 15912
#> 
#> $user$lang
#> [1] "en"
#> 
#> $user$contributors_enabled
#> [1] FALSE
#> 
#> $user$is_translator
#> [1] FALSE
#> 
#> $user$is_translation_enabled
#> [1] FALSE
#> 
#> $user$profile_background_color
#> [1] "EBEBEB"
#> 
#> $user$profile_background_image_url
#> [1] "http://abs.twimg.com/images/themes/theme7/bg.gif"
#> 
#> $user$profile_background_image_url_https
#> [1] "https://abs.twimg.com/images/themes/theme7/bg.gif"
#> 
#> $user$profile_background_tile
#> [1] FALSE
#> 
#> $user$profile_image_url
#> [1] "http://pbs.twimg.com/profile_images/615534833645678592/iAO_Lytr_normal.jpg"
#> 
#> $user$profile_image_url_https
#> [1] "https://pbs.twimg.com/profile_images/615534833645678592/iAO_Lytr_normal.jpg"
#> 
#> $user$profile_banner_url
#> [1] "https://pbs.twimg.com/profile_banners/64482503/1497895952"
#> 
#> $user$profile_link_color
#> [1] "CF1B41"
#> 
#> $user$profile_sidebar_border_color
#> [1] "FFFFFF"
#> 
#> $user$profile_sidebar_fill_color
#> [1] "F3F3F3"
#> 
#> $user$profile_text_color
#> [1] "333333"
#> 
#> $user$profile_use_background_image
#> [1] FALSE
#> 
#> $user$has_extended_profile
#> [1] FALSE
#> 
#> $user$default_profile
#> [1] FALSE
#> 
#> $user$default_profile_image
#> [1] FALSE
#> 
#> $user$following
#> [1] TRUE
#> 
#> $user$follow_request_sent
#> [1] FALSE
#> 
#> $user$notifications
#> [1] FALSE
#> 
#> $user$translator_type
#> [1] "none"
#> 
#> 
#> $geo
#> NULL
#> 
#> $coordinates
#> NULL
#> 
#> $place
#> NULL
#> 
#> $contributors
#> NULL
#> 
#> $is_quote_status
#> [1] FALSE
#> 
#> $retweet_count
#> [1] 0
#> 
#> $favorite_count
#> [1] 0
#> 
#> $favorited
#> [1] FALSE
#> 
#> $retweeted
#> [1] FALSE
#> 
#> $possibly_sensitive
#> [1] FALSE
#> 
#> $possibly_sensitive_appealable
#> [1] FALSE
#> 
#> $lang
#> [1] "en"
```

``` r
roomba(twitter_data, c("created_at", "name"))
#> # A tibble: 24 x 2
#>    name                 created_at                    
#>    <chr>                <chr>                         
#>  1 Code for America     Mon Aug 10 18:59:29 +0000 2009
#>  2 Ben Lorica <U+7F57><U+745E><U+5361>    Mon Dec 22 22:06:18 +0000 2008
#>  3 Dan Sholler          Thu Apr 03 20:09:24 +0000 2014
#>  4 Code for America     Mon Aug 10 18:59:29 +0000 2009
#>  5 FiveThirtyEight      Tue Jan 21 21:39:32 +0000 2014
#>  6 Digital Impact       Wed Oct 07 21:10:53 +0000 2009
#>  7 Drew Williams        Thu Aug 07 18:41:29 +0000 2014
#>  8 joe                  Fri May 29 13:25:25 +0000 2009
#>  9 Data Analysts 4 Good Wed May 07 16:55:33 +0000 2014
#> 10 Ryan Frederick       Sun Mar 01 19:06:53 +0000 2009
#> # ... with 14 more rows
```
