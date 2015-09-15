class Turn < ActiveRecord::Base
  belongs_to :round, inverse_of: :turns, counter_cache: true
  belongs_to :player, inverse_of: :turns
  has_many :moves, inverse_of: :turn, autosave: true, dependent: :destroy

  before_validation :set_turn_number, on: :create

  validates :round_id, :player_id,
    presence: { allow_blank: false }
  validates_with TurnValidator

  def hand
    round.hands.detect { |hand| hand.player_id == player_id }
  end

  private

  def set_turn_number
    self.position = round.turns.count
  end
end
