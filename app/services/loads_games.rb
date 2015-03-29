require 'light-service'
require './app/actions/imports_game_attributes_from_feed'
require './app/actions/instantiates_games_from_attributes'
require 'newrelic_rpm'
require './app/actions/persists_game_data'
require './app/actions/enqueues_iap_fetcher'

class LoadsGames
  include LightService::Organizer

  class << self
    include NewRelic::Agent::Instrumentation::ControllerInstrumentation

    def from_feed(feed, is_top_list = false)
      with(:feed => feed, :is_top_list => is_top_list).reduce(
        ImportsGameAttributesFromFeed,
        InstantiatesGamesFromAttributes,
        PersistsGameData,
        EnqueuesIAPFetcher
      )
    end
    add_transaction_tracer :from_feed, category: :task
  end
end
