require './lib/client/client'
require './lib/client/response'
require 'nokogiri'

class Client::AppleRSSFeedResponse < Client::Response
  attr_reader :document

  def initialize(response)
    @document = Nokogiri::XML(response.body).remove_namespaces!
    super
  end
end
