class JoinGame
  attr_reader :player

  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    @game.with_lock do
      !already_joined? && join_game
    end
  end

  private

  def already_joined?
    @game.players.any? { |player| player.user_id == @user.id }
  end

  def join_game
    @player = @game.players.create!(user: @user)
    signal_game_updated
    signal_joined_game
    true
  end

  def signal_game_updated
    game_data = ActiveModel::SerializableResource.new(@game).as_json
    Game.channel.trigger(:update, game_data)
  end

  def signal_joined_game
    player_data = ActiveModel::SerializableResource.new(@player).as_json
    @game.channel.trigger(:joined, player_data)
  end
end
