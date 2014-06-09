#!/usr/bin/ruby
require '../classes/Main'
require '../modules/read_config'

rss2tweet = Main.new
log_file=READ_CONFIG.get_property("log_file")
rss2tweet.get_tweets
log=rss2tweet.send_tweets
log.each {|tweet_log| File.open("#{log_file}","a") {|io| io.puts(tweet_log)}}
