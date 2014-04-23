require './lib/client/apple_rss_feed_response'
require 'http_helper'

describe "Client::AppleRSSFeedResponse" do
  describe "#document" do
    it "has a document property which contains the nokogiri parsed xml document" do
      disable_net_connect!
      stub_example_get_home_200
      response = Net::HTTP.get_response(URI('http://www.example.com'))
      client_response = Client::AppleRSSFeedResponse.new(response)
      expect(client_response.document).to be_instance_of(Nokogiri::XML::Document)
    end
  end
end
