require './app/models/game'

describe "Game" do
  describe "Properties" do
    it 'has the app_id property' do
      game = Game.new(:app_id => 5)
      expect(game.app_id).to eq(5)
    end
  end

  describe '#score' do
    let(:day) { 60 * 60 * 24 }
    let(:time) { (Time.now - day) }
    before do
      Time.stub(:now => Time.new(2014))
    end

    example "A game with 99.99 IAP beats a game with 4.99 IAP released on the same day" do
      game_1 = Game.new(:release_date => time, :top_iap_price => 99.99)
      game_2 = Game.new(:release_date => time, :top_iap_price => 4.99)
      expect(game_1.score).to be > game_2.score
    end

    example "A game with 5.99 IAP beats a game with 4.99 IAP released on the same day" do
      game_1 = Game.new(:release_date => time, :top_iap_price => 99.99)
      game_2 = Game.new(:release_date => time, :top_iap_price => 4.99)
      expect(game_1.score).to be > game_2.score
    end

    example "A game with 99.99 IAP released 1 month ago beats a game with 4.99 IAP released a day ago" do
      game_1 = Game.new(:release_date => Time.now - 30 * day, :top_iap_price => 99.99)
      game_2 = Game.new(:release_date => time, :top_iap_price => 4.99)
      expect(game_1.score).to be > game_2.score
    end

    example "A game with 99.99 IAP released 1 year ago is beaten by a game with 4.99 IAP released a day ago" do
      game_1 = Game.new(:release_date => Time.now - 365 * day, :top_iap_price => 99.99)
      game_2 = Game.new(:release_date => time, :top_iap_price => 4.99)
      expect(game_2.score).to be > game_1.score
    end
  end
end
