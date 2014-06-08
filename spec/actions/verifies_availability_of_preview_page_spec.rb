require 'http_helper'
require 'verifies_availability_of_preview_page'
require 'light-service'

describe "VerifiesAvailabilityOfPreviewPage" do
  it "Fails the context and deletes the game if the itunes launcher page appears instead" do
    disable_net_connect!
    stub_apple_app_preview_as_launcher_get_200
    preview_uri = "https://itunes.apple.com/us/app/jet-ski-ultimate-wave-race/id871114853?mt=8"
    context = LightService::Context.make({
      :games => [ Game.new(:app_id => 123, :preview_uri =>preview_uri) ]
    })

    context_with_page = FetchesAppPreviewPage.execute(context)
    result_context = VerifiesAvailabilityOfPreviewPage.execute(context_with_page)
    expect(result_context).to_not be_success
  end

  it "Passes along if the response is a real preview page" do
    disable_net_connect!
    stub_apple_app_preview_get_200
    preview_uri = "https://itunes.apple.com/us/app/jet-ski-ultimate-wave-race/id871114853?mt=8"
    context = LightService::Context.make({
      :games => [ Game.new(:app_id => 123, :preview_uri =>preview_uri) ]
    })

    context_with_page = FetchesAppPreviewPage.execute(context)
    result_context = VerifiesAvailabilityOfPreviewPage.execute(context_with_page)
    expect(result_context).to be_success
  end
end
