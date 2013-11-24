=begin
This module is responsible to short a url using the http://tinyurl.com/ service
=end
require 'net/http'

module SHORT_URL
	@base_url="http://tinyurl.com"
	@path_url="/api-create.php?url="

	def self.short(complete_url)
		uri= URI("#{@base_url}#{@path_url}#{complete_url}")
		response=Net::HTTP.get_response(uri)
		if response.is_a?(Net::HTTPSuccess) then
			return response.body
		else
			return "Request error: #{response.body}"
		end
	end

end