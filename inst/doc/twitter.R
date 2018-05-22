## ---- eval = FALSE-------------------------------------------------------
#  library(httr)
#  library(jsonlite)
#  
#  oauth_endpoints("twitter")
#  
#  myapp <- oauth_app("twitter",
#                     key = "EOy06ORJM56b8mk1yoUo6bnjG",
#                     secret = "8z4PMPIJrXKYE9JrALjI4TnzDJksB8xRphHj0L5JpWpSiEtbs6"
#  )
#  
#  twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)
#  
#  req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
#             config(token = twitter_token))
#  
#  stop_for_status(req)
#  
#  content(req)

## ---- echo=FALSE---------------------------------------------------------
library(tidyverse)
library(roomba)
data("twitter_data")

## ------------------------------------------------------------------------
twitter_data <- twitter_data

twitter_data %>% roomba(cols = c("followers_count", "friends_count")) %>% 
  ggplot(aes(x = followers_count, y = friends_count)) +
  geom_point() + 
  theme_minimal()

