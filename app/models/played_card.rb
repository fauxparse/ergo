class PlayedCard < ActiveRecord::Base
  belongs_to :premise, inverse_of: :played_cards

  def card
    Card.from_symbol(symbol.to_sym).rotate(rotation)
  end
end
