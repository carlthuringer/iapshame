require './app/client/response'
require 'net/http'
require 'http_helper'

describe "Response" do
  describe '#code' do
    it 'is the numeric representation of the http code returned' do
      disable_net_connect!
      stub_example_get_home_200
      response = Net::HTTP.get_response(URI('http://www.example.com'))
      client_response = Client::Response.new(response)
      expect(client_response.code).to eq(200)
    end
  end
end
