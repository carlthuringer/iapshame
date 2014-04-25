module SimpleSingleton
  module ClassMethods
    def get_instance
      @@instance ||= new
    end

    def set(method_symbol, object)
      get_instance.set(method_symbol, object)
    end

    def method_missing(meth, *args, &block)
      get_instance.send(meth, *args, &block)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def set(method_symbol, object)
    define_singleton_method(method_symbol) { object }
  end
end
