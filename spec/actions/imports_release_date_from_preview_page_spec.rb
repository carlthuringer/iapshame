require './app/actions/imports_release_date_from_preview_page'
require 'http_helper'

describe ImportsReleaseDateFromPreviewPage do
  it "assigns the imported release date to the game" do
    disable_net_connect!
    stub_apple_app_preview_with_iap_get_200
    response = Client::AppleAppPreviewPage.fetch_preview("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2")

    game = Game.new
    game.should_receive(:release_date=).with(Time.parse("2014-04-22 00:00:00 -0500"))
    context = { :game => game,
                :preview_page => response.document }
    ImportsReleaseDateFromPreviewPage.execute context
  end
end
