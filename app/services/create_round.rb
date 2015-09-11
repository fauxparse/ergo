class CreateRound
  attr_reader :round

  def initialize(game)
    @game = game
  end

  def call
    @game.with_lock do
      @round = @game.rounds.create!(position: @game.rounds_count)
      create_premises
      draw_starting_hands
      @round.reload
    end
  end

  private

  def create_premises
    Round::MAX_PREMISES.times.with_index do |position|
      round.premises.create!(position: position)
    end
  end

  def draw_starting_hands
    round.players.each { |player| draw_starting_hand(player) }
  end

  def draw_starting_hand(player)
    hand = Hand.create!(player: player, round: round)
    DrawCards.new(hand, Hand::SIZE).call
  end
end
