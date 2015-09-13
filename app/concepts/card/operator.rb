class Card::Operator < Card
  attr_reader :operator

  OPERATORS = {
    and:  Logic::AND,
    or:   Logic::OR,
    then: Logic::THEN
  }

  def initialize(operator, options = {})
    super(options)
    @operator = operator.to_sym
  end

  def to_sym
    @operator
  end

  def to_s
    OPERATORS[@operator]
  end
end
