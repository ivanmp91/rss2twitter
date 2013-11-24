=begin
This module is responsible to read he attributes from the json config file.
It simply returns the structure parsed with the attribute that you want.
=end
require 'json'

module READ_CONFIG

	file=open('../config/config.json')
	cnf_json=file.read

	@cnf_parsed=JSON.parse(cnf_json)

	def self.get_property(attribute)
		return @cnf_parsed[attribute]
	end
end