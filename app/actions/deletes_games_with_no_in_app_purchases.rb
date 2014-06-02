require 'light-service'

class DeletesGamesWithNoInAppPurchases
  include LightService::Action

  executed do |context|
    context[:games].select do |game|
      game.top_iap_title.nil?
    end.each do |no_iap_game|
      GameRepository.delete(no_iap_game)
    end.tap do |no_iap_games|
      context[:games] -= no_iap_games
    end
  end
end
