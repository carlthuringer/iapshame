class GamesController < ApplicationController
  def index
    @games = GameRepository.read_all
  end
end
