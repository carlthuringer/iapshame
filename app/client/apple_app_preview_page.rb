require 'net/http'
require './app/client/client'
require './app/client/apple_app_preview_response'
require 'rest-client'

class Client::AppleAppPreviewPage
  def self.fetch_preview(uri)
    user_agent = {:user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36"}
    retry_request -> { RestClient.get(uri, user_agent) }
    Client::AppleAppPreviewResponse.new(RestClient.get(uri))
  end

  def self.retry_request(request, attempts = 5)
    return if attempts == 0
    attempts -= 1
    request.call.tap do |response|
      return retry_request(request, attempts) unless [200..299].include? response.code
    end
  end
end
