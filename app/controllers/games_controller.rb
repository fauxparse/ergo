class GamesController < ApplicationController
  before_action :load_game, only: [:show]

  def index
    respond_to do |format|
      format.html
      format.json { render json: Game.with_players.all }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end

  def create
    create = CreateGame.new(current_user)
    if create.call
      redirect_to create.game
    else
      redirect_to root_path, error: t("games.create.failure")
    end
  end

  private

  def load_game
    @game = find_game(params[:id])
  end
end
