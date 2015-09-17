class PlayersController < ApplicationController
  before_action :load_game
  before_action :load_player, only: [:show, :update]

  wrap_parameters :player, include: [:ready]

  def create
    if JoinGame.new(@game, current_user).call
      redirect_to(@game)
    else
      redirect_to(games_path, error: t("errors.messages.could_not_join_game"))
    end
  end

  def show
    render json: @player
  end

  def update
    UpdatePlayer.new(@game, @player, player_params).call
    render json: @player
  end

  private

  def load_game
    @game = find_game(params[:game_id])
  end

  def load_player
    @player ||= if params[:id].present?
      @game.players.find(params[:id])
    else
      @game.players.detect { |player| player.user == current_user }
    end
  end

  def player_params
    params.require(:player).permit(:ready)
  end
end
