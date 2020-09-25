
require(rtweet)

api_key <- "YOUR KEY GOES HERE"
api_secret_key <- "YOUR KEY GOES HERE"
access_token <- "YOUR KEY GOES HERE"
access_token_secret <- "YOUR KEY GOES HERE"

token <- create_token(
  app = "YOUR APP NAME GOES HERE",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)

# COLLECTION - tweets containing #istandwithdan
tweet_search_istandwithdan <- search_tweets('#istandwithdan', n = 10000, include_rts = TRUE, retryonratelimit = TRUE)
saveRDS(tweet_search_istandwithdan, paste0(Sys.time()," tweet_search_istandwithdan.rds"))
length(unique(tweet_search_istandwithdan$screen_name))

# SAVE TO DISK
library(dplyr)
df_combined_istandwithdan <- tweet_search_istandwithdan %>% distinct(status_id, .keep_all = TRUE)
dim(df_combined_istandwithdan)
# subset only the columns we want to save to disk 
df_combined_istandwithdan_TO_DISK <- df_combined_istandwithdan[,c(1:6,14:16,48:62,63:66,82:83)]
write.csv(df_combined_istandwithdan_TO_DISK,paste0(Sys.time()," tweet_search_istandwithdan.csv"),row.names = F)
# write tweet IDs to disk
write.table(df_combined_istandwithdan$status_id,"istandwithdan_tweet_ids.csv", row.names = F, col.names = F, sep=",")


