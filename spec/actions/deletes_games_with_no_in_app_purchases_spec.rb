require './app/actions/deletes_games_with_no_in_app_purchases'

describe DeletesGamesWithNoInAppPurchases do
  context "Games are removed when they have no in app purchases" do

    let(:result_context) do
      game = Game.new(:app_id => 123)
      context = { :game => game }
      GameRepository.write(game)
      DeletesGamesWithNoInAppPurchases.execute(context)
    end

    it do
      expect(GameRepository.read(123)).to be_nil
    end

    it do
      expect(result_context).to be_skip_all
    end
  end
end
