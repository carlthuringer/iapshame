require './app/simple_singleton'
require 'yaml'

class AppSettings
  include SimpleSingleton
  def self.load(method_symbol, yml)
    get_instance.load(method_symbol, yml)
  end

  def load(method_symbol, yml)
    parsed_yml = YAML.load(yml)

    set(method_symbol, parsed_yml)
  end
end
