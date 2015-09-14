class ProofPresenter
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def to_s
    premise_presenters.map(&:to_s).join(",")
  end

  private

  def premise_presenters
    premises.map { |premise| PremisePresenter.new(premise) }
  end

  def premises
    round.premises.sort_by(&:position)
  end
end
