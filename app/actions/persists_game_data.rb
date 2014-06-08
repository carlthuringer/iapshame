require './app/models/game_repository'
require 'light-service'

class PersistsGameData
  include LightService::Action

  executed do |context|
    [context[:game], context[:games]]
      .flatten
      .compact
      .each do |game|
      GameRepository.write(game)
    end
  end
end
