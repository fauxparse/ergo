class Game < ActiveRecord::Base
  has_many :players, inverse_of: :game, dependent: :destroy
  has_many :rounds, inverse_of: :game, dependent: :destroy

  MAX_PLAYERS = 4

  def starting_player_number
    0
  end
end
