require 'light-service'
require './app/models/game'

class InstantiatesGamesFromAttributes
  include LightService::Action

  executed do |context|
    attributes = context.fetch(:game_attributes)
    context[:games] = attributes.map{|attrs| Game.new(attrs)}
  end
end
