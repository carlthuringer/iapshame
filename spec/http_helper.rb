require 'webmock/rspec'

module WebStubs
  def disable_net_connect!
    WebMock.disable_net_connect!
  end

  def enable_net_connect!
    WebMock.enable_net_connect!
  end

  def stub_apple_rss_feed_games_get_200
    stub_request(:get, %q{https://itunes.apple.com/us/rss/newapplications/xml})
      .to_return(File.open('./spec/fixtures/http/apple/rss_feed_games_get_200.txt'))
  end

  def stub_example_get_home_200
    stub_request(:get, %q{http://www.example.com}).to_return(File.open('./spec/fixtures/http/example/get_home_200.txt'))
  end

  def stub_apple_app_preview_get_200
    stub_request(:get, %r{https://itunes\.apple\.com/us/app/.*}).to_return(File.open('./spec/fixtures/http/apple/app_preview_get_200.txt'))
  end

  def stub_apple_app_preview_with_iap_get_200
    stub_request(:get, %r{https://itunes\.apple\.com/us/app/.*}).to_return(File.open('./spec/fixtures/http/apple/app_preview_with_iap_get_200.txt'))
  end

  def stub_apple_app_preview_with_iap_clash_of_clans_get_200
    stub_request(:get, %r{https://itunes\.apple\.com/us/app/.*}).to_return(File.open('./spec/fixtures/http/apple/app_preview_with_iap_get_clash_of_clans_200.txt'))
  end
end

RSpec.configure do |config|
  config.include WebStubs
end
