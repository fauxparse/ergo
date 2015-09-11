class Hand < ActiveRecord::Base
  belongs_to :player, inverse_of: :hands
  belongs_to :round, inverse_of: :hands

  SIZE = 5

  scope :for_player, -> (player) { where(player_id: player.id) }

  validates :player_id, :round_id,
    presence: { allow_blank: false }

  def cards
    cards_array.map { |card| Card.from_symbol(card) }
  end

  def cards=(array)
    self.cards_array = array.map(&:to_sym)
  end
end
