class Client::Response
  attr_reader :code
  def initialize(response)
    @code = response.code.to_i
  end
end
