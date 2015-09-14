class Round < ActiveRecord::Base
  belongs_to :game, inverse_of: :rounds, counter_cache: true
  has_many :hands, inverse_of: :round, dependent: :destroy, autosave: true
  has_many :premises, inverse_of: :round, dependent: :destroy, autosave: true
  has_many :turns, inverse_of: :round, dependent: :destroy, autosave: true
  has_many :effect_cards, inverse_of: :round, dependent: :destroy,
    autosave: true

  MAX_PREMISES = 4

  enum state: [:playing, :finished]

  before_validation :initialize_deck, if: :new_record?

  validates :game_id, :cards_remaining, presence: { allow_blank: false }

  def players
    @players ||= game.players.sort_by(&:position)
      .rotate(starting_player_number)
  end

  def active_player
    players[turns.count % players.length]
  end

  def deck
    @deck ||= Deck.new(seed: random_seed)
  end

  private

  def starting_player_number
    (game.starting_player_number + position) % game.players_count
  end

  def initialize_deck
    self.cards_remaining = deck.size
  end

  def random_seed
    id
  end
end
