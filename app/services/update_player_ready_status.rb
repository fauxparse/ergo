class UpdatePlayerReadyStatus
  def initialize(game, player, ready)
    @game = game
    @player = player
    @ready = ready
  end

  def call
    update_ready_status if @game.rounds.empty?
  end

  private

  def update_ready_status
    @game.with_lock do
      @player.update!(ready: @ready)
      @game.channel.trigger(:ready, @player.id => @player.ready)
      start_game if enough_players? && everyone_is_ready?
      true
    end
  end

  def start_game
    CreateRound.new(@game).call if @game.rounds.empty?
  end

  def ready_to_start?
    @game.rounds.empty? && enough_players? && everyone_is_ready?
  end

  def enough_players?
    @game.players.size > 1
  end

  def everyone_is_ready?
    @game.players.all?(&:ready)
  end
end
