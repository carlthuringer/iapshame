require './lib/client/client'
require './lib/client/response'
require 'nokogiri'

class Client::AppleAppPreviewResponse < Client::Response
  attr_reader :document

  def initialize(response)
    @document = Nokogiri::HTML(response.body)
    super
  end
end
