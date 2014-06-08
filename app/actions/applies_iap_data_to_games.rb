require 'light-service'

class AppliesIAPDataToGames
  include LightService::Action
  expects :game, :iap_data

  executed do |context|
    max_iap = context.iap_data.max_by{|item| item[:price]}
    next unless max_iap
    context.game.top_iap_title = max_iap[:text]
    context.game.top_iap_price = max_iap[:price]
  end
end
