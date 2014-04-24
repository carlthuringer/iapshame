require 'http_helper'
require './lib/client/apple_app_preview_page'
require 'nokogiri'

describe "Client::AppleAppPreviewPage" do
  it 'successfully fetches the preview page' do
    disable_net_connect!
    stub_apple_app_preview_get_200
    uri = "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"
    response = Client::AppleAppPreviewPage.fetch_preview(uri)
    expect(response.code).to eq(200)
  end

  it 'returns a response with a document' do
    disable_net_connect!
    stub_apple_app_preview_get_200
    uri = "https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"
    response = Client::AppleAppPreviewPage.fetch_preview(uri)
    expect(response.document).to be_instance_of(Nokogiri::HTML::Document)
  end
end
