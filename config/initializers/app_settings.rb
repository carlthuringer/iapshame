require './config/app_settings'

Dir['./config/settings/*.yml'].each do |config_yml_path|
  method_name = File.basename(config_yml).gsub(/\.yml$/, '')
  file = File.open(config_yml_path)
  AppSettings.load(method_name, file)
end
