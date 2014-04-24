require 'light-service'
require './actions/imports_game_attributes_from_feed'

class LoadsGames
  include LightService::Organizer

  def self.from_feed(feed)
    with(:feed => feed).reduce(
      ImportsGameAttributesFromFeed,
      InstantiatesGamesFromAttributes,
      FetchesAppPreviewPage,
      ImportsIAPDataFromPreviewPage,
      AppliesIAPDataToGames,
    )
  end
end
