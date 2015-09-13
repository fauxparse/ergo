class DrawCards
  attr_reader :hand, :cards

  def initialize(hand, number_of_cards_to_draw = 1)
    @hand = hand
    @number_of_cards_to_draw = number_of_cards_to_draw
  end

  def call
    round.with_lock { add_cards_to_hand }
  end

  delegate :round, to: :hand

  private

  def add_cards_to_hand
    hand.with_lock do
      hand.cards_array += cards.map(&:to_sym)
      round.cards_remaining -= cards.length
      hand.save!
      round.save!
      true
    end
  end

  def cards
    @cards ||= round.deck[-round.cards_remaining, draws]
  end

  def draws
    [@number_of_cards_to_draw, round.cards_remaining].min
  end
end
