require './actions/instantiates_games_from_attributes'

describe "InstantiatesGamesFromAttributes" do
  it "Creates a new game object for each item in the attributes hash with the attributes supplied in the context" do
    game_attributes = [{
      :app_id => 123
    }]
    context = { :game_attributes => game_attributes }

    result_context = InstantiatesGamesFromAttributes.execute(context)
    expect(result_context[:games].first).to be_instance_of(Game)
    expect(result_context[:games].first.app_id).to eq(123)
  end
end
