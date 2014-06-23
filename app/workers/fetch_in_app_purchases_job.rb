require './app/models/game_repository'
require './app/services/fetches_in_app_purchases'

class FetchInAppPurchasesJob
  @queue = 'iap-fetch'

  def self.perform(app_id)
    # 2 seconds is too slow to keep up with the data at a rate of 1 fetch per hour.
    # 1 second is too fast and gets forbidden
    sleep 2 # Try not to blow the rate limiter on apple's preview site
    game = GameRepository.read(app_id)
    return if game.nil?
    FetchesInAppPurchases.for_game(game)
  end
end
