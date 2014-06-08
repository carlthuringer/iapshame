require 'light-service'

class DeletesGamesWithNoInAppPurchases
  include LightService::Action
  expects :game

  executed do |context|
    if context.game.top_iap_title.nil?
      GameRepository.delete(context.game)
      context.skip_all!
    end
  end
end
