class BeginTurn
  attr_reader :round, :turn

  def initialize(round)
    @round = round
  end

  def call
    @turn = round.turns.build(player: player, position: round.turns.count)
  end

  private

  def player
    round.active_player
  end
end
