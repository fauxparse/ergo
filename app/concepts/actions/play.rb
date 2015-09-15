module Actions
  class Play < Action
    def apply
      card.play(turn, player, options)
      remove_card_from_hand
    end
  end
end
