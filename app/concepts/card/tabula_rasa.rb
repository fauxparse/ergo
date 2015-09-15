class Card::TabulaRasa < Card
  def play(turn, player, options)
    premise = turn.round.premises.detect { |p| p.position == options[:premise] }
    premise
      .played_cards.detect { |card| card.position == options[:position] }
      .mark_for_destruction
  end
end
