require 'spec_helper'
require 'http_helper'

describe "FetchesAppPreviewPage" do
  it "uses the Client::AppleAppPreviewPage to add a hash of id => html page to the context" do
    disable_net_connect!
    stub_apple_app_preview_get_200
    preview_uri = "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"
    context = { :game => Game.new(:app_id => 123, :preview_uri => preview_uri) }
    result_context = FetchesAppPreviewPage.execute(context)
    expect(result_context[:preview_page]).to_not be_nil
  end

  it "fails the context and deletes the game if the preview page comes back NWK" do
    disable_net_connect!
    stub_apple_app_preview_get_NWK_200
    preview_uri = "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"
    context = { :game => Game.new(:app_id => 123, :preview_uri => preview_uri) }
    result_context = FetchesAppPreviewPage.execute(context)
    expect(result_context).to_not be_success
  end
end
