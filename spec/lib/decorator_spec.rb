require './app/decorator'

class Foo
  def bar
    'bar'
  end
end

class Baz
  def bar
    'baz'
  end

  def baz
    'baz'
  end
end

describe "Decorator" do
  describe "#decorate" do
    it "Returns an instance of the object which has been decorated and now responds to the #with method" do
      foo = Foo.new
      Decorator.decorate(foo)
      expect(foo).to respond_to(:with)
    end
  end

  describe "Decorated objects" do
    it "when Foo is decorated with Baz, it responds to baz" do
      foo = Foo.new
      Decorator.decorate(foo).with(Baz.new)
      expect(foo.baz).to eq('baz')
    end

    it "when Foo is decorated with Baz it does not call bar on Baz" do
      foo = Foo.new
      Decorator.decorate(foo).with(Baz.new)
      expect(foo.bar).to eq('bar')
    end

    it "raises an undefined method error on Foo when unknown method is called" do
      foo = Foo.new
      Decorator.decorate(foo).with(Baz.new)
      expect{ foo.baff }.to raise_error(NoMethodError)
    end

    it "does not double-decorate decorated objects" do
      foo = Foo.new
      Decorator.decorate(foo).with(Baz.new)
      Decorator.decorate(foo)
      expect(foo.delegate_list.length).to eq(1)
    end
  end
end
