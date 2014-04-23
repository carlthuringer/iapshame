require 'yaml'

class AppSettings
  def self.load(method_symbol, yml)
    get_instance.load(method_symbol, yml)
  end

  def self.get_instance
    @@instance ||= new
  end

  def load(method_symbol, yml)
    parsed_yml = YAML.load(yml)

    define_singleton_method(method_symbol) { parsed_yml }
  end

  def self.method_missing(meth, *args, &block)
    get_instance.send(meth, *args, &block)
  end
end
