require './app/models/game'

describe "Game" do
  describe "Properties" do
    it 'has the app_id property' do
      game = Game.new(:app_id => 5)
      expect(game.app_id).to eq(5)
    end
  end
end
