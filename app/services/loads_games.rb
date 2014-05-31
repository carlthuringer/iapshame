require 'light-service'
require './app/actions/imports_game_attributes_from_feed'
require './app/actions/instantiates_games_from_attributes'
require './app/actions/persists_game_data'
require './app/actions/enqueues_iap_fetcher'

class LoadsGames
  include LightService::Organizer

  def self.from_feed(feed, is_top_list = false)
    with(:feed => feed, :is_top_list => is_top_list).reduce(
      ImportsGameAttributesFromFeed,
      InstantiatesGamesFromAttributes,
      PersistsGameData,
      EnqueuesIAPFetcher
    )
  end
end
