require 'net/http'
require './lib/clients/clients'
class Client::AppleRSSFeed
  def self.fetch_new_games
    uri = URI(AppSettings.urls[:apple_new_games_feed])
    Net::HTTP.get_response(uri)
  end
end
