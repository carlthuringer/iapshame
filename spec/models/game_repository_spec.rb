require './app/models/game_repository'
require 'fakeredis/rspec'
require 'json'

describe "GameRepository" do
  before do
    @redis = Redis.new
  end

  describe "#write" do
    it 'saves a game to Redis' do
      game = Game.new(:app_id => 111, :name => "FooGame")
      GameRepository.write(game)
      expect(JSON.parse(@redis.get(111))['name']).to eq("FooGame")
      @redis.del(111)
    end
  end

  describe "#read" do
    it 'loads a game from redis' do
      game_attrs = Game.new(:app_id => 111, :name => "FooGame").attributes.to_json
      @redis.set(111, game_attrs)
      game = GameRepository.read(111)
      expect(game.name).to eq("FooGame")
    end
  end
end
