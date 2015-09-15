class Card::ProofComponent < Card
  def play(turn, player, options)
    premise = premise_at_position(turn.round, options[:premise])
    position = options[:position]
    move_cards_right(premise.played_cards, position)
    insert_new_card(premise.played_cards, position, options)
  end

  private

  def premise_at_position(round, position)
    round.premises.detect { |p| p.position == position } ||
      round.premises.build(position: position)
  end

  def move_cards_right(cards, position)
    cards.each { |card| card.position += 1 if card.position >= position }
  end

  def insert_new_card(cards, position, options)
    cards.build(
      position: position,
      symbol: to_sym,
      rotation: options[:rotation] || 0
    )
  end
end
