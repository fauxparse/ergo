class Card::Therefore < Card::Effect
  def to_sym
    :ergo
  end

  def play(turn, player, effect)
    turn.round.state = :finished
  end
end
