require './config/app_settings'

describe "AppSettings" do
  describe "Instance behavior" do
    it "Is a singleton" do
      expect(AppSettings.get_instance).to eq(AppSettings.get_instance)
    end
  end

  describe "::load" do
    it "loads configuration from a provided settings YML" do
      input_yml = <<-YML
      :apple: http://www.apple.com
      YML
      AppSettings.load(:urls, input_yml)
      expect(AppSettings.urls[:apple]).to eq("http://www.apple.com")
    end
  end
end
