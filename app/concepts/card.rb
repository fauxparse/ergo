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

  TRANSLATIONS = {
    Variable    => "A".."D",
    Operator    =>
      [Logic::AND, Logic::OR, Logic::THEN, "and", "or", "then"],
    Not         => [Logic::NOT, "not"],
    Parenthesis => ["(", ")", "parenthesis"],
    Therefore   => [Logic::THEREFORE, "ergo", "therefore"]
  }

  def self.from_symbol(symbol)
    TRANSLATIONS.each_pair do |klass, strings|
      return from_class(klass, symbol) if strings.include?(symbol.to_s)
    end

    const_get(symbol.to_s.camelize).new
  end

  def self.from_class(klass, symbol)
    if klass == Parenthesis
      klass.new.rotate(symbol.to_s == ")" ? 2 : 0)
    elsif klass == Variable || klass == Operator
      klass.new(symbol.to_sym)
    else
      klass.new
    end
  end
end
