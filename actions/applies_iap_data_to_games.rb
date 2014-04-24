require 'light-service'

class AppliesIAPDataToGames
  include LightService::Action

  executed do |context|
    iap_data = context.fetch(:iap_data)
    games = context.fetch(:games)
    games_by_app_id = games.group_by(&:app_id)
    iap_data.each do |app_id, iap_list|
      game = games_by_app_id[app_id].first
      max_iap = iap_list.max_by{|item| item[:price]}
      next unless max_iap
      max_iap.tap do |iap|
        game.top_iap_title = iap[:text]
        game.top_iap_price = iap[:price]
      end
    end
  end
end
