require './app/actions/persists_game_data'
require './app/models/game_repository'

describe "PersistsGameData" do
  it "uses game repository to save a game" do
    game = Game.new
    context = {
      :game => game
    }

    GameRepository.stub(:write)
    expect(GameRepository).to receive(:write)
    PersistsGameData.execute(context)
  end

  it "uses GameRepository to save multiple games" do
    game_1 = Game.new
    game_2 = Game.new
    context = {
      :games => [game_1, game_2]
    }

    GameRepository.stub(:write)
    expect(GameRepository).to receive(:write).twice
    PersistsGameData.execute(context)
  end
end
