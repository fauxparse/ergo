module Logic
  class BinaryOperator < Expression
    child :left, Expression
    child :right, Expression

    def to_s
      "(#{left} #{operator} #{right})"
    end

    def eql?(other)
      other.is_a?(BinaryOperator) &&
      operator == other.operator &&
      operands_equal?(other)
    end

    def operands_equal?(other)
      ((left.eql?(other.left) && right.eql?(other.right)) ||
      (left.eql?(other.right) && right.eql?(other.left)))
    end
  end
end
