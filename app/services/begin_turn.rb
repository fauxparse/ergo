class BeginTurn
  attr_reader :round, :turn

  def initialize(round)
    @round = round
  end

  def call
    @turn = round.turns.build(player: player, position: round.turns.count)
    round.effect_cards.each { |effect| effect.beginning_of_turn(@turn) }
  end

  private

  def player
    round.active_player
  end
end
