# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'resque/tasks'

task "resque:setup" => :environment

desc "Load environment"
task :environment do
  require File.join File.dirname(__FILE__), 'config', 'boot'
end

namespace :feed_processing do
  desc "Gets new games from Apple RSS feed and persists them to Redis"
  task :get_new_games => :environment do
    AppSettings.urls.each do |name, url|
      p name, url
      uri = URI(url)
      games_feed = Client::AppleRSSFeed.fetch_feed(uri)
      is_top_list_feed = name.match(/top/)
      LoadsGames.from_feed(games_feed.document, is_top_list_feed)
      # Ensure data is sent to new relic
      ::NewRelic::Agent.shutdown
    end
  end

  desc "Re-fetch In-App Purchases"
  task :refetch_in_app_purchases => :environment do
    GameRepository.read_all.each do |game|
      Resque.enqueue(FetchInAppPurchasesJob, game.app_id)
    end
  end
end
