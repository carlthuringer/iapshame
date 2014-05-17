require './app/models/game_repository'
require './app/services/fetches_in_app_purchases'

class FetchInAppPurchasesJob
  @queue = 'iap-fetch'

  def self.perform(app_id)
    game = GameRepository.read(app_id)
    FetchesInAppPurchases.for_game(game)
  end
end
