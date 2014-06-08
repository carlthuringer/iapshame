require './app/actions/applies_iap_data_to_games'
require './app/models/game'

describe "AppliesIAPDataToGames" do
  it "puts the data of the highest IAP on the game with the same app id" do
    iap_data = [
      {
        :text => "A box",
        :price => 0.99
      },
      {
        :text => "A box of Crap",
        :price => 99.99
      }
    ]

    context = {
      :iap_data => iap_data,
      :game => Game.new(:app_id => 111)
    }

    result_context = AppliesIAPDataToGames.execute(context)
    game = result_context[:game]
    expect(game.top_iap_title).to eq("A box of Crap")
    expect(game.top_iap_price).to eq(99.99)
  end

  it 'Does not set any data if there is no IAP' do
    context = {
      :iap_data => {
      },
      :game => Game.new(:app_id => 111)
    }

    result_context = AppliesIAPDataToGames.execute(context)
    game = result_context[:game]
    expect(game.top_iap_title).to be_nil
    expect(game.top_iap_price).to be_nil
  end
end
