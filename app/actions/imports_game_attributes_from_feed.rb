require './app/importer/game'
require 'light-service'

class ImportsGameAttributesFromFeed
  include LightService::Action

  executed do |context|
    feed = context.fetch(:feed)
    is_top_list = context.fetch(:is_top_list)
    context[:game_attributes] = Importer::Game.import_feed_document(feed, is_top_list)
  end
end
