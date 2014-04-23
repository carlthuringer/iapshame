require './config/app_settings'

module AppConfigStubs
  def load_app_config
    require './config/initializers/app_settings'
  end
end

RSpec.configure do |config|
  config.include AppConfigStubs
end
