module Actions
  class TabulaRasa < Action
    def apply
      destroy_card
      move_cards_left
      remove_card_from_hand
    end

    private

    def position
      options[:position]
    end

    def move_cards_left
      premise.played_cards
        .each { |card| card.position -= 1 if card.position > position }
    end

    def destroy_card
      premise
        .played_cards.detect { |card| card.position == position }
        .mark_for_destruction
    end
  end
end
