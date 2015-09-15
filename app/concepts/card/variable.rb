class Card::Variable < Card::ProofComponent
  attr_reader :variable

  def initialize(variable, options = {})
    super(options)
    @variable = variable.to_sym
  end

  def to_sym
    @variable
  end

  def to_s
    @variable.to_s
  end
end
