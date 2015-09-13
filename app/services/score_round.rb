class ScoreRound
  attr_reader :round

  delegate :players, to: :round

  def initialize(round)
    @round = round
  end

  def call
    round.with_lock do
      players.each do |player|
        player.with_lock do
          player.update!(score: player.score + player_score(player))
        end
      end
    end
  end

  def paradox?
    variables.any? do |variable|
      solver.proved?(variable) && solver.disproved?(variable)
    end
  end

  private

  def variables
    Deck::VARIABLES.to_a
  end

  def solver
    @solver ||= Logic::Solver.new(statements).solve!
  end

  def statements
    premises.map { |premise| statement(premise) }
  end

  def premises
    round.premises.sort_by(&:position)
  end

  def statement(premise)
    RowPresenter.new(premise).to_s
  end

  def player_score(player)
    if paradox? || !solver.proved?(player.goal)
      0
    else
      total_cards
    end
  end

  def total_cards
    @total_cards ||= premises.map { |p| p.played_cards.length }.sum
  end
end
