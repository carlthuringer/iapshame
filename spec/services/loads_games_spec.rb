require './services/loads_games'
require './lib/client/apple_rss_feed'
require './workers/fetch_in_app_purchases_job'
require 'http_helper'
require 'app_settings_helper'
require 'fakeredis'
require 'resque'

describe "LoadsGames" do
  describe '#from_feed' do
    it 'returns a list of fully-populated games which are persisted to redis' do
      load_app_config
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      stub_apple_app_preview_with_iap_get_200
      feed_response = Client::AppleRSSFeed.fetch_new_games
      Resque.stub(:enqueue)
      result = LoadsGames.from_feed(feed_response.document)
      game = result.fetch(:games).first
      game_id = game.app_id
      expected_attributes = {
        :app_id => 854533196,
        :name => "4.0.9.6",
        :developer_name => "Shane Clifford",
        :preview_uri => "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2",
        :image_uri => "http://a1919.phobos.apple.com/us/r30/Purple/v4/06/ab/62/06ab62fe-76dd-9b16-a155-b6180b0ec9f1/mzl.ohrotgzr.100x100-75.png",
        :release_date => "2014-04-21T18:38:48-07:00",
        :top_iap_title => nil,
        :top_iap_price => nil
      }
      game_from_redis = GameRepository.read(game_id)
      expect(game_from_redis.attributes).to eq(expected_attributes)
    end

    it "Queues a resque job to load the IAP data" do
      load_app_config
      disable_net_connect!
      stub_apple_rss_feed_games_get_200
      stub_apple_app_preview_with_iap_get_200
      feed_response = Client::AppleRSSFeed.fetch_new_games

      expect(Resque).to receive(:enqueue).with(FetchInAppPurchasesJob, anything).exactly(100).times

      LoadsGames.from_feed(feed_response.document)
    end
  end
end
