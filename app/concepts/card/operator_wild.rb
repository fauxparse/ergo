class Card::OperatorWild < Card::Wild
  private

  def behaviours
    [:and, :then, :not, :or]
  end
end
