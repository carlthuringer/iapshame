require 'light-service'
require 'game_repository'

class RejectsNonApprovedCategoryIds
  include LightService::Action

  executed do |context|
    games = context[:games] || [context[:game]]
    games.each do |game|
      if not approved_category_ids.include?(game.genre)
        GameRepository.delete(game)
        games.delete(game)
      end
    end

    if games.empty?
      context.fail!
    end
  end

  private

  def self.approved_category_ids
    AppSettings.approved_category_ids
  end
end
