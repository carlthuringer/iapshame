require './app/actions/applies_iap_data_to_games'
require './app/models/game'

describe "AppliesIAPDataToGames" do
  it "puts the data of the highest IAP on the game with the same app id" do
    game_1_iap = [
      {
        :text => "A box",
        :price => 0.99
      },
      {
        :text => "A box of Crap",
        :price => 99.99
      }
    ]

    game_2_iap = [
      {
        :text => "Nothing",
        :price => 14.99
      }
    ]

    iap_data = {
      111 => game_1_iap,
      222 => game_2_iap
    }
    context = {
      :iap_data => iap_data,
      :games => [Game.new(:app_id => 111), Game.new(:app_id => 222)]
    }

    result_context = AppliesIAPDataToGames.execute(context)
    game1 = result_context[:games].find{|g| g.app_id == 111}
    game2 = result_context[:games].find{|g| g.app_id == 222}
    expect(game1.top_iap_title).to eq("A box of Crap")
    expect(game1.top_iap_price).to eq(99.99)
    expect(game2.top_iap_title).to eq("Nothing")
    expect(game2.top_iap_price).to eq(14.99)
  end

  it 'Does not fail if there is no IAP' do
    context = {
      :iap_data => {
        111 => []
      },
      :games => [Game.new(:app_id => 111)]
    }

    result_context = AppliesIAPDataToGames.execute(context)
    game1 = result_context[:games].find{|g| g.app_id == 111}
    expect(game1.top_iap_title).to be_nil
    expect(game1.top_iap_price).to be_nil
  end
end
