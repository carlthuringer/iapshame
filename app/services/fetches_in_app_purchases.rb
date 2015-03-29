require 'light-service'
require 'fetches_app_preview_page'
require 'imports_iap_data_from_preview_page'
require 'imports_genre_from_preview_page'
require 'rejects_non_approved_category_ids'
require 'applies_iap_data_to_games'
require 'deletes_games_with_no_in_app_purchases'
require 'imports_release_date_from_preview_page'
require 'persists_game_data'

class FetchesInAppPurchases
  include LightService::Organizer

  class << self
    include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

    def for_game(game)
      with(:game => game).reduce(
        FetchesAppPreviewPage,
        ImportsIAPDataFromPreviewPage,
        ImportsGenreFromPreviewPage,
        RejectsNonApprovedCategoryIds,
        AppliesIAPDataToGames,
        DeletesGamesWithNoInAppPurchases,
        PersistsGameData
      )
    end
    add_transaction_tracer :for_game, category: :task
  end
end
