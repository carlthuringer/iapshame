require './actions/imports_game_attributes_from_feed'

describe "ImportsGameAttributesFromFeed" do
  it "Uses the Importer::Game class to import attributes from the feed passed in context" do
    feed = double
    attributes = double
    context = { :feed => feed }
    Importer::Game.stub(:import_feed_document).and_return(attributes)
    result_context = ImportsGameAttributesFromFeed.execute(context)
    expect(Importer::Game).to have_received(:import_feed_document).with(feed)
    expect(result_context.fetch(:game_attributes)).to eq(attributes)
  end
end
