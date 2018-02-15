# Include required packages
library(httpuv)
library(rtweet)

## name assigned to created app
appname <- "rtweet_token"
## api key (example below is not a real key)
key <- "[KEY_HERE]"
## api secret (example below is not a real key)
secret <- "[SECRET_HERE]"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

## Search for tweets
rt <- search_tweets("New England Tech", n = 5000, token = twitter_token)
## Show the tweets data
list(rt)
## Save tweets data locally
save_as_csv(rt, "NEIT_Twitter_Data")
## Create time series plot
ts_plot(rt, by=".5 days", lwd=.75, theme="light", main="New England Tech", subtitle="Latest 5000 records")

## Search for tweets
pt1 <- search_tweets("Advanced Institute of Industrial Technology", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt1, "Advanced Institute of Industrial Technology")
## Create time series plot
ts_plot(pt1, by=".5 days", lwd=.75, theme="light", main="Advanced Institute of Industrial Technology", subtitle="Latest 5000 records")

## Search for tweets
pt2 <- search_tweets("Arnauld", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt2, "Arnauld")
## Create time series plot
ts_plot(pt2, by=".5 days", lwd=.75, theme="light", main="Arnauld", subtitle="Latest 5000 records")

## Search for tweets
pt3 <- search_tweets("Rhode Island History", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt3, "Rhode Island History")
## Create time series plot
ts_plot(pt3, by=".5 days", lwd=.75, theme="light", main="Rhode Island History", subtitle="Latest 5000 records")

## Search for tweets
pt4 <- search_tweets("Latest Technological Developments", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt4, "Latest Technological Developments")
## Create time series plot
ts_plot(pt4, by=".5 days", lwd=.75, theme="light", main="Latest Technological Developments", subtitle="Latest 5000 records")

## Search for tweets
pt5 <- search_tweets("Modern Music of the World", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt5, "Modern Music of the World")
## Create time series plot
ts_plot(pt5, by="day", lwd=.75, theme="light", main="World Music", subtitle="Latest 5000 records")

## Search for tweets
pt6 <- search_tweets("Information Technology Career Opportunities", n = 5000, token = twitter_token)
## Save tweets data locally
save_as_csv(pt6, "Information Technology Career Opportunities")
## Create time series plot
ts_plot(pt6, by=".5 days", lwd=.75, theme="light", main="Information Technology Career Opportunities", subtitle="Latest 5000 records")