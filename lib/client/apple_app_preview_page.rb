require 'net/http'
require './lib/client/client'
require './lib/client/apple_app_preview_response'
require 'rest-client'

class Client::AppleAppPreviewPage
  def self.fetch_preview(uri)
    Client::AppleAppPreviewResponse.new(RestClient.get(uri))
  end
end
