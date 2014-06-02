require './app/importer/iap_data'
require './app/client/apple_app_preview_page'
require 'http_helper'

describe "Importer::IAPData" do
  describe "#import_preview_page_iap" do
    it 'transforms a preview page into a hash of attributes' do
      disable_net_connect!
      stub_apple_app_preview_with_iap_get_200
      response = Client::AppleAppPreviewPage.fetch_preview("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2")
      imported = Importer::IAPData.import_preview_page_iap(response.document)
      expected = [{
        :text => "Random Button",
        :price => 0.99
      }]
      expect(imported).to eq(expected)
    end

    it 'correctly collects all in app purchases' do
      disable_net_connect!
      stub_apple_app_preview_with_iap_clash_of_clans_get_200
      response = Client::AppleAppPreviewPage.fetch_preview("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2")
      imported = Importer::IAPData.import_preview_page_iap(response.document)
      expected = [
        {:text=>"Pile of Gems", :price=>4.99},
        {:text=>"Bag of Gems", :price=>9.99},
        {:text=>"Sack of Gems", :price=>19.99},
        {:text=>"Box of Gems", :price=>49.99},
        {:text=>"Chest of Gems", :price=>99.99}
      ]

      expect(imported).to eq(expected)
    end
  end

  describe "#import_preview_page_release_date" do
    it 'transforms a preview page into a hash of attributes' do
      disable_net_connect!
      stub_apple_app_preview_with_iap_get_200
      response = Client::AppleAppPreviewPage.fetch_preview("https://itunes.apple.com/us/app/4.0.9.6/id854533196?mt=8&uo=2")
      imported = Importer::IAPData.import_preview_page_release_date(response.document)
      expected = "Apr 22, 2014"

      expect(imported).to eq(expected)
    end
  end
end
