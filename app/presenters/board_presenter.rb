class BoardPresenter
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def to_s
    row_presenters.map(&:to_s).join(",")
  end

  private

  def row_presenters
    round.premises.sort_by(&:position)
      .map { |premise| RowPresenter.new(premise) }
  end
end
