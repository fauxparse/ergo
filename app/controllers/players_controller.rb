class PlayersController < ApplicationController
  before_action :load_game

  def create
    if JoinGame.new(@game, current_user).call
      redirect_to(@game)
    else
      redirect_to(games_path, error: t("errors.messages.could_not_join_game"))
    end
  end

  private

  def load_game
    @game = find_game(params[:game_id])
  end
end
