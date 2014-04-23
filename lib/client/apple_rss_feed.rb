require 'net/http'
require './lib/client/client'
require './lib/client/apple_rss_feed_response'
require 'nokogiri'

class Client::AppleRSSFeed
  def self.fetch_new_games
    uri = URI(AppSettings.urls[:apple_new_games_feed])
    Client::AppleRSSFeedResponse.new(Net::HTTP.get_response(uri))
  end
end
