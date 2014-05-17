require './app/workers/fetch_in_app_purchases_job'
require 'light-service'
require 'resque'

class EnqueuesIAPFetcher
  include LightService::Action

  executed do |context|
    games = context.fetch(:games)
    games.each do |game|
      Resque.enqueue(FetchInAppPurchasesJob, game.app_id)
    end
  end
end
