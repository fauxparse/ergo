module Logic
  class Not < Expression
    child :operand, Expression

    def to_s
      "~(#{operand})"
    end

    def eql?(other)
      other.is_a?(Not) &&
      other.operand.eql?(operand)
    end

    def negated
      operand
    end
  end
end
