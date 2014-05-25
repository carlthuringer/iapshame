class GamePresenter
  def initialize(game)
    @game = game
  end

  def image_uri
    @game.image_uri
  end

  def title
    @game.name
  end

  def top_iap_title
    @game.top_iap_title
  end

  def top_iap_price
    @game.top_iap_price
  end
end
