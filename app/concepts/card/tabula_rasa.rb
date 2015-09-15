class Card::TabulaRasa < Card
  def play(turn, player, options)
    premise = turn.round.premises.detect { |p| p.position == options[:premise] }
    position = options[:position]
    remove_card_at(premise.played_cards, position)
    move_cards_left(premise.played_cards, position)
  end

  private

  def remove_card_at(cards, position)
    cards.each { |card| card.mark_for_destruction if card.position == position }
  end

  def move_cards_left(cards, position)
    cards.each { |card| card.position -= 1 if card.position > position }
  end
end
