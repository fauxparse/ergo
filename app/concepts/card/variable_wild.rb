class Card::VariableWild < Card::Wild
  private

  def behaviours
    [:A, :B, :C, :D]
  end
end
