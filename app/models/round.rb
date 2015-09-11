class Round < ActiveRecord::Base
  belongs_to :game, inverse_of: :rounds, counter_cache: true
  has_many :hands, inverse_of: :round, dependent: :destroy
  has_many :premises, inverse_of: :round, dependent: :destroy

  MAX_PREMISES = 4

  before_validation :initialize_deck, if: :new_record?

  validates :game_id, :cards_remaining, presence: { allow_blank: false }

  def players
    @players ||= game.players.sort_by(&:position)
      .rotate(starting_player_number)
  end

  def active_player
    players[turn_number % players.length]
  end

  def deck
    @deck ||= Deck.new(seed: random_seed)
  end

  private

  def starting_player_number
    (game_id + position) % game.players_count
  end

  def initialize_deck
    self.cards_remaining = deck.size
  end

  def random_seed
    id
  end
end
