require './app/importer/game'
require 'light-service'

class ImportsGameAttributesFromFeed
  include LightService::Action

  expects :feed, :is_top_list
  promises :game_attributes

  executed do |context|
    context.game_attributes = Importer::Game.import_feed_document(context.feed, context.is_top_list)
  end
end
