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
      expect(JSON.parse(@redis.get("game:111"))['name']).to eq("FooGame")
    end

    it "also writes the game's score to redis" do
      game = Game.new(:app_id => 111, :name => "FooGame")
      GameRepository.write(game)
      expect(@redis.zrank("game_scores", 111)).to be_present
    end
  end

  describe "#read" do
    it 'loads a game from redis' do
      game_attrs = Game.new(:app_id => 111, :name => "FooGame").attributes.to_json
      @redis.set("game:111", game_attrs)
      game = GameRepository.read(111)
      expect(game.name).to eq("FooGame")
    end

    it 'returns nil when no game is found' do
      expect(GameRepository.read(999)).to be_nil
    end
  end

  describe "#delete" do
    it "Removes a game from redis" do
      game = Game.new(:app_id => 111, :name => "FooGame")
      GameRepository.write(game)
      GameRepository.delete(game)
      expect(@redis.get("game:111")).to be_nil
    end
  end
end
