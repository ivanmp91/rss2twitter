=begin
This class it's just to define the properties for a tweet and 
a method to return the string with a tweet message
=end
class Tweet
	@hash_tag

	def initialize(url,data)
		@url=url
		@data=data
	end

	def set_hash_tag(tag)
		@hash_tag=tag
	end

	def to_s
		return "#{@data} #{@url} ##{@hash_tag}" unless @hash_tag.nil?
		return "#{@data} #{@url}"
	end
end
