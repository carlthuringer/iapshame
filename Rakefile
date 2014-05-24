# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'resque/tasks'

desc "Load environment"
task :environment do
  require File.join File.dirname(__FILE__), 'config', 'boot'
end

namespace :feed_processing do
  desc "Gets new games from Apple RSS feed and persists them to Redis"
  task :get_new_games => :environment do
    games_feed = Client::AppleRSSFeed.fetch_new_games
    LoadsGames.from_feed(games_feed.document)
  end
end
