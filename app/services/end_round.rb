class EndRound
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def call
    round.update!(state: :finished)
    ScoreRound.new(round).call
  end
end
