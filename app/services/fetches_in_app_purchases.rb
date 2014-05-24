require 'light-service'
require 'fetches_app_preview_page'
require 'imports_iap_data_from_preview_page'
require 'applies_iap_data_to_games'
require 'persists_game_data'

class FetchesInAppPurchases
  include LightService::Organizer

  def self.for_game(game)
    with(:games => [game]).reduce(
      FetchesAppPreviewPage,
      ImportsIAPDataFromPreviewPage,
      AppliesIAPDataToGames,
      PersistsGameData
    )
  end
end
