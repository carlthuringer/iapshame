require './app/models/game_repository'
require './app/services/fetches_in_app_purchases'

class FetchInAppPurchasesJob
  @queue = 'iap-fetch'

  def self.perform(app_id)
    sleep 0.1 # Try not to blow the rate limiter on apple's preview site
    game = GameRepository.read(app_id)
    return unless game.present?
    FetchesInAppPurchases.for_game(game)
  end
end
