module Logic
  class Solver
    attr_reader :expressions

    def initialize(statements)
      @expressions = statements.map { |statement| parse(statement) }
      @values = {}
    end

    def solve!
      loop do
        apply_rules || break
      end
      self
    end

    def proved?(expression)
      @expressions.include?(expression)
    end

    def disproved?(expression)
      @expressions.include?(expression.negated)
    end

    def proved
      @expressions
        .select(&:variable?)
        .map(&:name)
        .sort
        .uniq
    end

    def disproved
      @expressions
        .select { |expr| expr.to_sym == :not && expr.operand.variable? }
        .map(&:operand)
        .map(&:name)
        .sort
        .uniq
    end

    def paradoxes
      proved & disproved
    end

    def parse(statement)
      Logic::Parser.parse(lex(statement))
    end

    private

    def apply_rules
      count = @expressions.length
      rules.each(&:apply)
      @expressions.length != count
    end

    def lex(statement)
      Logic::Lexer.lex(statement)
    end

    def rule_classes
      [
        SplitAnd, Idempotence, Involution, ModusPonens, ModusTollens,
        DisjunctiveSyllogism, HypotheticalSyllogism, Absorption, DeMorgan
      ]
    end

    def rules
      @rules ||= rule_classes.map { |klass| klass.new(self) }
    end
  end
end
