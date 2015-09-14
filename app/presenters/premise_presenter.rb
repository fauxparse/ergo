class PremisePresenter
  attr_reader :premise

  def initialize(premise)
    @premise = premise
  end

  def to_s
    cards.map(&:to_s).join
  end

  private

  def cards
    premise.played_cards.sort_by(&:position).map do |played|
      Card.from_symbol(played.symbol).rotate(played.rotation)
    end
  end
end
