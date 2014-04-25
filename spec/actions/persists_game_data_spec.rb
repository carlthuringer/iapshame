require './actions/persists_game_data'
require './app/models/game_repository'

describe "PersistsGameData" do
  it "uses game repository to save each game" do
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
