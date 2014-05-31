require 'net/http'
require 'app_settings'
require './app/client/client'
require './app/client/apple_rss_feed_response'

class Client::AppleRSSFeed
  def self.fetch_feed(uri)
    Client::AppleRSSFeedResponse.new(Net::HTTP.get_response(uri))
  end
end
