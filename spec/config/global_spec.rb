require './config/global'

describe "Global" do
  describe "Instance behavior" do
    it "Is a singleton" do
      expect(Global.get_instance).to eq(Global.get_instance)
    end
  end

  describe "::set" do
    it "allows you to create a method" do
      double_redis = double(:redis)
      Global.set(:redis, double_redis)
      expect(Global.redis).to eq(double_redis)
    end
  end
end
