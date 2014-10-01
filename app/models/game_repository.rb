require './app/models/game'
require 'json'

class GameRepository
  def self.write(game)
    connection.set(keyspace(game.app_id), game.attributes.to_json)
    connection.zadd(game_score_key, game.score, game.app_id)
  end

  def self.read(app_id)
    if app_id.to_s.match(/game/)
      keyspaced_id = app_id
    else
      keyspaced_id = keyspace(app_id)
    end

    if found_game = connection.get(keyspaced_id)
      parsed_attrs = JSON.parse(found_game)
      Game.new(parsed_attrs)
    else
      nil
    end
  end

  def self.delete(game)
    connection.del(keyspace(game.app_id))
    connection.zrem(game_score_key, game.app_id)
  end

  def self.read_all
    connection.keys(keyspace).map{|app_id| read app_id}
  end

  def self.read_all_ordered
    connection.zrevrange(game_score_key, 0, -1).map do |app_id|
      read app_id
    end
  end

  def self.read_top_100
    connection.zrevrange(game_score_key, 0, 100).map do |app_id|
      read app_id
    end
  end

  def self.clear_and_rescore
    connection.del(game_score_key)
    read_all.each{|game| write game}
  end

  def self.game_score_key
    'game_scores'
  end

  def self.keyspace(id = '*')
    "game:#{id}"
  end

  def self.connection
    @@connection ||= Redis.new
  end
end
