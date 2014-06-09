=begin
Main class to work with the application. This class is 
responsible to load the data from json configuration file,	
set and get the time from the last update from all the channels,
and tweet all the last rss feeds from the last update.
=end
require '../modules/read_config'
require '../modules/send_tweet'
require '../classes/FeedParse'
require '../classes/Tweet'

class Main

	@@properties = {
		cache_file:  READ_CONFIG.get_property("cache_file"),
		consumer_key: READ_CONFIG.get_property("consumer_key"),
		consumer_secret: READ_CONFIG.get_property("consumer_secret"),
		access_token: READ_CONFIG.get_property("access_token"),
		access_token_secret: READ_CONFIG.get_property("access_token_secret"),
		twitter_api_uri: READ_CONFIG.get_property("twitter_api_uri"),
		channels: READ_CONFIG.get_property("channels")
	}

	def initialize 
		@urls=Hash.new
		@tweets=[]
		get_timestamp
		@@parser=FeedParse.new(@time)
	end
	#Call to parse the rss for all the url channels and convert to tweet messages
	def get_tweets
		@@properties[:channels].each do |channel| 
			@urls[channel["title"].to_sym]=Hash.new
			@urls[channel["title"].to_sym][:url]=channel["url"]
			@urls[channel["title"].to_sym][:hash_tag]=channel["hash_tag"]
		end
		@@parser.parse(@urls)
		@tweets=@@parser.get_tweets
	end

	#Update the status of the twitter account with the tweets and return an array with the response for all the updates
	def send_tweets
		SEND_TWEET.set_properties(@@properties)
		tweet_log=[]
		@tweets.each {|tweet| tweet_log.push(SEND_TWEET.send(tweet.to_s))} if @tweets.count > 0
		set_timestamp if @tweets.count > 0
		return tweet_log
	end

	private

	#Read the date object from the binary file located in the json settings, if not exists create it with the current date
	def get_timestamp
		if File.exist?(@@properties[:cache_file].to_s) then
			File.open(@@properties[:cache_file].to_s, 'rb') {|f| @time=Marshal.load(f)}
		else
			@time= Time.now.utc.iso8601
			File.open(@@properties[:cache_file].to_s, 'wb' ) do |file|
  				Marshal.dump(@time,file)
			end
		end
	end

	#Update the binary file with the current time
	def set_timestamp
		File.truncate(@@properties[:cache_file].to_s,0)
		time_now= Time.now.utc.iso8601
		File.open(@@properties[:cache_file].to_s, 'wb' ) do |file|
  			Marshal.dump(time_now,file)
		end
	end	
end
