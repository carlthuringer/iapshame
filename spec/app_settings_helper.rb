require './config/app_settings'

module AppConfigStubs
  def load_app_config
    AppSettings.load(:urls, File.open('./config/urls.yml'))
  end
end

RSpec.configure do |config|
  config.include AppConfigStubs
end
