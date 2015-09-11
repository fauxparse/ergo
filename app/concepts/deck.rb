class Deck
  VARIABLES = 'A'..'D'
  OPERATORS = [:and, :or, :then]

  def initialize(seed: nil)
    @seed = seed || Random.new_seed
  end

  def size
    cards.length
  end

  def cards
    @cards ||= unshuffled.shuffle(random: generator)
  end

  delegate :[], to: :cards

  private

  def generator
    @generator || Random.new(@seed)
  end

  def unshuffled
    variable_cards +
    operator_cards +
    not_cards +
    parenthesis_cards +
    ergo_cards +
    gameplay_cards
  end

  def build_cards(n, klass, *args)
    (1..n).map { klass.new(*args) }
  end

  def variable_cards
    VARIABLES.flat_map do |variable|
      build_cards(4, Card::Variable, variable)
    end
  end

  def operator_cards
    OPERATORS.flat_map do |operator|
      build_cards(4, Card::Operator, operator)
    end
  end

  def not_cards
    build_cards(8, Card::Not)
  end

  def parenthesis_cards
    build_cards(6, Card::Parenthesis)
  end

  def ergo_cards
    build_cards(3, Card::Therefore)
  end

  def gameplay_cards
    fallacy_cards +
    justification_cards +
    tabula_rasa_cards +
    revolution_cards +
    wild_cards
  end

  def fallacy_cards
    build_cards(3, Card::Fallacy)
  end

  def justification_cards
    build_cards(3, Card::Justification)
  end

  def tabula_rasa_cards
    build_cards(1, Card::TabulaRasa)
  end

  def revolution_cards
    build_cards(1, Card::Revolution)
  end

  def wild_cards
    build_cards(1, Card::VariableWild) +
    build_cards(1, Card::OperatorWild)
  end
end
