class Client::Response
  attr_reader :code
  def initialize(response)
    @response = response
  end

  def code
    @response.code.to_i
  end

  def headers
    @response.headers
  end
end
