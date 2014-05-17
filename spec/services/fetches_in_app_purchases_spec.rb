require './app/services/fetches_in_app_purchases'
require 'http_helper'
require 'fakeredis'

describe "FetchesInAppPurchases" do
  describe '#for_game' do
    it "Gets the in app purchases for a game and saves them to Redis" do
      game = Game.new(
        :app_id => 854533196,
        :name => "4.0.9.6",
        :developer_name => "Shane Clifford",
        :preview_uri => "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2",
        :image_uri => "http://a1919.phobos.apple.com/us/r30/Purple/v4/06/ab/62/06ab62fe-76dd-9b16-a155-b6180b0ec9f1/mzl.ohrotgzr.100x100-75.png",
        :release_date => "2014-04-21T18:38:48-07:00",
      )

      disable_net_connect!
      stub_apple_app_preview_with_iap_get_200
      GameRepository.write(game)
      FetchesInAppPurchases.for_game(game)
      game_from_redis = GameRepository.read(game.app_id)
      expect(game_from_redis.top_iap_title).to eq("Random Button")
      expect(game_from_redis.top_iap_price).to eq(0.99)
    end
  end
end
