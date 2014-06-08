module AssignableAttributes
  module ClassMethods
    def attr_accessor(*attrs)
      @accessible_attributes ||= []
      @accessible_attributes = @accessible_attributes | attrs
      super
    end

    def get_accessible_attributes
      @accessible_attributes
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def initialize(attributes = {})
    self.assign_attributes(attributes)
  end

  def assign_attributes(attrs)
    attrs.each do |name, value|
      send("#{name}=", value) if respond_to?(name) && respond_to?("#{name}=")
    end
  end

  def attributes
    Hash[self.class.get_accessible_attributes.map{|k| [k, send(k)]}]
  end
end
