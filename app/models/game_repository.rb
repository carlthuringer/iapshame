require './app/models/game'
require 'redis'
require 'json'

class GameRepository
  def self.write(game)
    connection.set(game.app_id, game.attributes.to_json)
  end

  def self.read(app_id)
    parsed_attrs = JSON.parse(connection.get(app_id))
    Game.new(parsed_attrs)
  end

  def self.connection
    @@connection ||= Redis.new
  end
end
