class Hand < ActiveRecord::Base
  belongs_to :player, inverse_of: :hands
  belongs_to :round, inverse_of: :hands

  SIZE = 5

  scope :for_player, -> (player) { where(player_id: player.id) }
  scope :for_round, -> (round) { where(round_id: round.id) }

  before_validation :remove_blank_cards

  validates :player_id, :round_id,
    presence: { allow_blank: false }

  def cards
    cards_array.map { |card| card && Card.from_symbol(card) }
  end

  def cards=(array)
    self.cards_array = array.map(&:to_sym)
  end

  private

  def remove_blank_cards
    cards_array.compact!
  end
end
