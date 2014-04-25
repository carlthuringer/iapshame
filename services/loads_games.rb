require 'light-service'
require './actions/imports_game_attributes_from_feed'
require './actions/instantiates_games_from_attributes'
require './actions/persists_game_data'
require './actions/enqueues_iap_fetcher'

class LoadsGames
  include LightService::Organizer

  def self.from_feed(feed)
    with(:feed => feed).reduce(
      ImportsGameAttributesFromFeed,
      InstantiatesGamesFromAttributes,
      PersistsGameData,
      EnqueuesIAPFetcher
    )
  end
end
