module Actions
  class Insert < Action
    def apply
      move_cards_right
      insert_new_card
      remove_card_from_hand
    end

    private

    def position
      options[:position] || premise.played_cards.length
    end

    def move_cards_right
      premise.played_cards
        .each { |card| card.position += 1 if card.position >= position }
    end

    def insert_new_card
      premise.played_cards.build(
        position: position,
        symbol: card.to_sym,
        rotation: options[:rotation] || 0
      )
    end
  end
end
