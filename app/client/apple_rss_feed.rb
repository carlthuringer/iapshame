require 'net/http'
require './app/client/client'
require './app/client/apple_rss_feed_response'

class Client::AppleRSSFeed
  def self.fetch_new_games
    uri = URI(AppSettings.urls[:apple_new_games_feed])
    Client::AppleRSSFeedResponse.new(Net::HTTP.get_response(uri))
  end
end