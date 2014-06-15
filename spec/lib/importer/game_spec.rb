require './app/importer/game'
require './app/client/apple_rss_feed'
require 'http_helper'

describe 'Importer::Game' do
  describe '#import' do
    it 'transforms a feed document into a hash of attributes' do
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      response = Client::AppleRSSFeed.fetch_feed(URI('https://itunes.apple.com/us/rss/newapplications/xml'))
      imported = Importer::Game.import_feed_document(response.document, true)
      expected = {
        :app_id => 854533196,
        :name => "4.0.9.6",
        :developer_name => "Shane Clifford",
        :preview_uri => "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2",
        :image_uri => "http://a1919.phobos.apple.com/us/r30/Purple/v4/06/ab/62/06ab62fe-76dd-9b16-a155-b6180b0ec9f1/mzl.ohrotgzr.100x100-75.png",
        :release_date => "2014-04-22T13:42:11-07:00",
        :top_list_rank => 1,
        :genre => 6014
      }
      expect(imported.first).to eq(expected)
    end
  end
end
