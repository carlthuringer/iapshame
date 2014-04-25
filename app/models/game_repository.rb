require './app/models/game'
require 'redis'
require 'json'

class GameRepository
  def self.write(game)
    connection.set(keyspace(game.app_id), game.attributes.to_json)
  end

  def self.read(app_id)
    if app_id.to_s.match(/game/)
      keyspaced_id = app_id
    else
      keyspaced_id = keyspace(app_id)
    end
    parsed_attrs = JSON.parse(connection.get(keyspaced_id))
    Game.new(parsed_attrs)
  end

  def self.read_all
    connection.keys(keyspace).map{|app_id| read app_id}
  end

  def self.keyspace(id = '*')
    "game:#{id}"
  end

  def self.connection
    @@connection ||= Redis.new
  end
end
