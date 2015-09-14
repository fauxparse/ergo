class Card::Wild < Card
  def behaviour
    Card.from_symbol(acting_as)
  end

  def can_rotate_to?(rotation)
    (0..3).include?(rotation)
  end

  delegate :to_s, to: :acting_as

  private

  def acting_as
    behaviours[rotation]
  end

  def behaviours
    [to_sym] * 4
  end
end
