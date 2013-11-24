=begin
This module is responsible to connect with the twitter api and 
send the tweet message to the account
=end
require 'oauth'
require 'json'

module SEND_TWEET

	# Set the access token and consumer key from the json settings
	def self.set_properties(properties)
		@consumer_key=OAuth::Consumer.new("#{properties[:consumer_key]}","#{properties[:consumer_secret]}")
		@access_token=OAuth::Token.new("#{properties[:access_token]}","#{properties[:access_token_secret]}")
		@twitter_url=URI("#{properties[:twitter_api_uri]}/statuses/update.json")
	end

	#send twitter message
	def self.send(message)
		request = Net::HTTP::Post.new @twitter_url.request_uri
		request.set_form_data(
			"status"=> "#{message}",
		)
		return self.http_request(request)
	end

	private
	#Prepare the https request and handle the response from the twitter api returning a message with the response status
	def self.http_request(request)
		http=Net::HTTP.new @twitter_url.host,@twitter_url.port
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_PEER
		request.oauth! http, @consumer_key,@access_token
		http.start
		response=http.request request
		tweet=nil
		time_now=Time.new
		if response.code == '200' then
			tweet = JSON.parse(response.body)
			return "sent tweet at #{tweet['created_at']} with message #{tweet['text']}"
		else
			return "#{time_now} Code:#{response.code} Body:#{response.body}"
		end
	end
end