require './app/importer/game'
require 'light-service'

class ImportsGameAttributesFromFeed
  include LightService::Action

  executed do |context|
    feed = context.fetch(:feed)
    context[:game_attributes] = Importer::Game.import_feed_document(feed)
  end
end
