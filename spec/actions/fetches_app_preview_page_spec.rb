require './actions/fetches_app_preview_page'

describe "FetchesAppPreviewPage" do
  it "uses the Client::AppleAppPreviewPage to add a hash of id => html page to the context" do
    page = double(:page)
    response = double(:document, :document => page)
    preview_uri = "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"
    context = { :games => [Game.new(:app_id => 123, :preview_uri => preview_uri)] }
    Client::AppleAppPreviewPage.stub(:fetch_preview => response)
    result_context = FetchesAppPreviewPage.execute(context)
    expect(Client::AppleAppPreviewPage).to have_received(:fetch_preview).with(preview_uri)
    expect(result_context[:preview_pages][123]).to eq(page)
  end
end
