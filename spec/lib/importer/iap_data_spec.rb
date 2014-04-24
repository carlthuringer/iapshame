require './lib/importer/iap_data'
require './lib/client/apple_app_preview_page'
require 'http_helper'

describe "Importer::IAPData" do
  describe "#import_preview_page" do
    it 'transforms a preview page into a hash of attributes' do
      disable_net_connect!
      stub_apple_app_preview_with_iap_get_200
      response = Client::AppleAppPreviewPage.fetch_preview("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2")
      imported = Importer::IAPData.import_preview_page(response.document)
      expected = [{
        :text => "Random Button",
        :price => 0.99
      }]
      expect(imported).to eq(expected)
    end
  end
end
