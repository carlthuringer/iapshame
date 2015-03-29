require 'rubygems'
require 'bundler/setup'

[Dir[File.join File.dirname(__FILE__), *%w{.. app **}],
 Dir[File.join File.dirname(__FILE__), '..', 'config']]
  .flatten
  .each{|dir| $: << dir}

Dir[File.join File.dirname(__FILE__), '..', 'config', 'initializers', '*']
  .each do |initializer|
  require initializer
end

ENV['RAILS_ENV'] ||= 'production'

require 'newrelic_rpm'

require 'active_support'
require 'apple_rss_feed'
require 'loads_games'
require 'game_presenter'

#$: << File.join(File.dirname(__FILE__), *%w{.. app})
