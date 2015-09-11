class AddPlayer
  attr_reader :player

  def initialize(game)
    @game = game
  end

  def call
    @game.with_lock do
      can_add_player? && add_player && true
    end
  end

  private

  def can_add_player?
    @game.players.count < Game::MAX_PLAYERS
  end

  def add_player
    @player = @game.players.create!(position: @game.players.count)
  end
end
