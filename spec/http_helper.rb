require 'webmock/rspec'

module WebStubs
  def disable_net_connect!
    WebMock.disable_net_connect!
  end

  def enable_net_connect!
    WebMock.enable_net_connect!
  end

  def stub_apple_rss_feed_games_get_200
    stub_request(:get, %q{https://itunes.apple.com/us/rss/newapplications/limit=10/genre=6014/xml})
      .to_return(File.open('./spec/fixtures/http/apple/rss_feed_games_get_200.txt'))
  end
end

RSpec.configure do |config|
  config.include WebStubs
end
