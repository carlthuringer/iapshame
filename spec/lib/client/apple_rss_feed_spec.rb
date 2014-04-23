require './lib/client/apple_rss_feed'
require 'http_helper'
require 'app_settings_helper'

describe "AppleRSSFeed" do
  describe '#fetch_new_games' do
    it 'successfully fetches new games' do
      load_app_config
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      response = Client::AppleRSSFeed.fetch_new_games
      expect(response.code).to eq(200)
    end

    it 'returns a response with a document' do
      load_app_config
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      response = Client::AppleRSSFeed.fetch_new_games
      expect(response.document).to be_instance_of(Nokogiri::XML::Document)
    end
  end
end
