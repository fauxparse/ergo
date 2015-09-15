class Card::Parenthesis < Card::ProofComponent
  def to_sym
    @rotation == 2 && :")" || :"("
  end

  def to_s
    @rotation == 2 && ")" || "("
  end

  def can_rotate_to?(rotation)
    rotation == 0 || rotation == 2
  end
end
