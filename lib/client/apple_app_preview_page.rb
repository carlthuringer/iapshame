require 'net/http'
require './lib/client/client'
require './lib/client/apple_app_preview_response'
require 'nokogiri'

class Client::AppleAppPreviewPage
  def self.fetch_preview(uri)
    uri = URI(uri)
    Client::AppleAppPreviewResponse.new(Net::HTTP.get_response(uri))
  end
end
