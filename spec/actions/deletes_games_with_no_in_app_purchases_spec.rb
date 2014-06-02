require './app/actions/deletes_games_with_no_in_app_purchases'

describe DeletesGamesWithNoInAppPurchases do
  context "Games are removed when they have no in app purchases" do

    let(:result_context) do
      game_1 = Game.new(:app_id => 123, :top_iap_title => "Hi", :top_iap_price => 4.99)
      game_2 = Game.new(:app_id => 456)
      context = { :games => [ game_1, game_2 ] }
      GameRepository.write(game_1)
      GameRepository.write(game_2)
      DeletesGamesWithNoInAppPurchases.execute(context)
    end

    it do
      expect(GameRepository.read(456)).to be_nil
    end

    it do
      expect(result_context[:games]).to have(1).item
    end
  end
end
