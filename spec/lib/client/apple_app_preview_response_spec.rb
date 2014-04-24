require './lib/client/apple_app_preview_response'
require 'http_helper'

describe "Client::AppleAppPreviewResponse" do
  describe "#document" do
    it "has a document property which contains the nokogiri parsed http document" do
      disable_net_connect!
      stub_apple_app_preview_get_200
      response = Net::HTTP.get_response(URI("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&amp;uo=2"))
      client_response = Client::AppleAppPreviewResponse.new(response)
      expect(client_response.document).to be_instance_of(Nokogiri::HTML::Document)
    end
  end
end
