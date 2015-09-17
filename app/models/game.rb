require "pleasant_lawyer"

class Game < ActiveRecord::Base
  has_many :players, inverse_of: :game, dependent: :destroy
  has_many :rounds, inverse_of: :game, dependent: :destroy

  MAX_PLAYERS = 4

  scope :with_players, -> { preload(:players => :user) }

  def to_param
    PleasantLawyer.convert(id).join("-")
  end

  def starting_player_number
    0
  end

  def channel
    WebsocketRails[to_param]
  end

  def self.channel
    WebSocketRails[:_games]
  end
end
