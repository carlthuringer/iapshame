require 'light-service'

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
