namespace :feed_processing do
  desc "Gets new games from Apple RSS feed and persists them to Redis"
  task :get_new_games => :environment do
    games_feed = Client::AppleRSSFeed.fetch_new_games
    LoadsGames.from_feed(games_feed.document)
  end
end
