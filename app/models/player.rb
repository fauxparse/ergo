class Player < ActiveRecord::Base
  belongs_to :game, inverse_of: :players, counter_cache: true
  has_many :hands, inverse_of: :player, dependent: :destroy
  has_many :turns, inverse_of: :player, dependent: :destroy

  validates :game_id,
    presence: { allow_blank: false }

  validates :position,
    presence: { allow_blank: false },
    numericality: { only_integer: true }
end
