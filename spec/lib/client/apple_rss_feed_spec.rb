require './app/client/apple_rss_feed'
require 'http_helper'

describe "AppleRSSFeed" do
  describe '#fetch_feed' do
    it 'successfully fetches new games' do
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      response = Client::AppleRSSFeed.fetch_feed(URI('https://itunes.apple.com/us/rss/newapplications/xml'))
      expect(response.code).to eq(200)
    end

    it 'returns a response with a document' do
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      response = Client::AppleRSSFeed.fetch_feed(URI('https://itunes.apple.com/us/rss/newapplications/xml'))
      expect(response.document).to be_instance_of(Nokogiri::XML::Document)
    end
  end
end
