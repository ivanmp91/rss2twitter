=begin
This class is responsible to connect with the rss channel and convert 
the last post messages to tweets
=end
require 'rss'
require 'open-uri'
require '../classes/Tweet'
require '../modules/short_url'

class FeedParse
	
	def initialize(last_update)
		@tweets=[]
		@last_update=DateTime.parse(last_update)
	end

	#parse all the url channels, if the pubDate is greater than the date from the last check update
	#then will short the url of the post, get the title and convert to a tweet object. If the channel
	#was assigned a hash tag, then the tweet will contains the hash_tag.
	def parse(urls)
		urls.each do |title,properties|
			open(properties[:url]) do |rss|
				feed=RSS::Parser.parse(rss)
				feed.items.each do |item|
					date=DateTime.parse("#{item.pubDate}")
					if date >= @last_update then
						item_url=item.link
						short_url=SHORT_URL.short(item_url)
						tweet=Tweet.new(short_url,item.title)
						tweet.set_hash_tag(properties[:hash_tag]) unless properties[:hash_tag].nil?
						@tweets.push(tweet)
					end
				end
			end
		end
	end

	def get_tweets
		return @tweets
	end

end
