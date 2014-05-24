require './config/app_settings'

module AppConfigStubs
  def load_app_config
    require './config/initializers/app_settings'
  end

  def stub_apple_rss_feed
    AppSettings.load :urls, <<-YML
      :apple_new_games_feed: https://itunes.apple.com/us/rss/newapplications/xml
    YML
  end
end

RSpec.configure do |config|
  config.include AppConfigStubs
end
