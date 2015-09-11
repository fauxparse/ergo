class Card
  attr_reader :rotation

  def initialize(options = {})
    @rotation = options[:rotation] || 0
  end

  def to_sym
    self.class.name.demodulize.underscore.to_sym
  end

  def behaviour
    self
  end

  def can_rotate_to?(_)
    false
  end

  def self.from_symbol(symbol)
    case symbol.to_s
    when "A"..."D" then Variable.new(symbol)
    when "and", "or", "then" then Operator.new(symbol.to_sym)
    when "(", ")" then Parenthesis.new
    when "ergo" then Therefore.new
    else
      const_get(symbol.to_s.camelize).new
    end
  end
end
