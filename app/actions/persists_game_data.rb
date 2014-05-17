require './app/models/game_repository'
require 'light-service'

class PersistsGameData
  include LightService::Action

  executed do |context|
    games = context.fetch(:games)
    games.each do |game|
      GameRepository.write(game)
    end
  end
end
