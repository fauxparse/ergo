module Actions
  class Discard < Action
    def apply
      remove_card_from_hand
    end
  end
end
