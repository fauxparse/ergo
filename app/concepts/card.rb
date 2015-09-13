class Card
  attr_reader :rotation

  def initialize(options = {})
    @rotation = options[:rotation] || 0
  end

  def to_sym
    self.class.name.demodulize.underscore.to_sym
  end

  def eql?(other)
    to_sym == other.to_sym
  end

  def behaviour
    self
  end

  def can_rotate_to?(_)
    false
  end

  def rotate(rotation)
    @rotation = rotation if can_rotate_to?(rotation)
    self
  end

  def self.from_symbol(symbol)
    case symbol.to_s
    when "A".."D" then Variable.new(symbol)
    when "and", "or", "then" then Operator.new(symbol.to_sym)
    when Logic::AND then Operator.new(:and)
    when Logic::OR then Operator.new(:or)
    when Logic::NOT then Operator.new(:not)
    when Logic::THEN then Operator.new(:then)
    when "(", ")", "parenthesis" then Parenthesis.new
    when "∴", "ergo" then Therefore.new
    else
      const_get(symbol.to_s.camelize).new
    end
  end
end
