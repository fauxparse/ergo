class EffectCard < ActiveRecord::Base
  belongs_to :round, inverse_of: :effect_cards
  belongs_to :player
  belongs_to :target, class_name: "Player"

  def card
    Card.from_symbol(symbol.to_sym).rotate(rotation)
  end
end
