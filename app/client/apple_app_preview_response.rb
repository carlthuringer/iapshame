require './app/client/client'
require './app/client/response'
require 'nokogiri'

class Client::AppleAppPreviewResponse < Client::Response
  attr_reader :document

  def initialize(response)
    @document = Nokogiri::HTML(response.body)
    super
  end
end
