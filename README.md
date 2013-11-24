rss2twitter
===========
Ruby program to parse RSS channels and send to twitter

REQUIREMENTS 

- To use this program you've to use a minimum version of Ruby 1.9.3 and install the oauth gem:

	$ sudo gem install oauth
	
CONFIGURATION

- Put the project folder under any location on the system. Ex:

	$ cp -p rss2twitter/ /usr/local/bin/
	
- You need to register an application with your twitter account and create a consumer key, consumer secret, an access token and access secret. For more information visit: https://dev.twitter.com/apps

- Edit the configuration file rss2twitter/config/config.json and setup your twitter account settings. With this configuration file you can put all the channels that you want to tweet under the array channels and setup a hash tag for each channel to include in all thr tweets.

- Create the directory /var/cache/rss2twitter/ and the file /var/log/rss2twitter.log with write permissions for the user that will run the program. Change the location for the file and the directory if you change it on the configuration file.

- Setup a cron task to run the program. The script you've to run is $LOCATION/rss2twitter/bin/rss2twitter.rb

CONTACT

Please if you see any error or you've any suggestion please contact me at ivan@opentodo.net
