module Logic
  class Solver
    class DeMorgan < Rule
      def apply_to_expression(expression)
        apply_de_morgan(expression) if expression.to_sym == :not
      end

      private

      def apply_de_morgan(expression)
        negated_or(expression.operand) if expression.operand.to_sym == :or
        negated_and(expression.operand) if expression.operand.to_sym == :and
      end

      def negated_or(subexpr)
        append(subexpr.left.negated, subexpr.right.negated)
      end

      def negated_and(subexpr)
        append(Logic::Or.new(subexpr.left.negated, subexpr.right.negated))
      end
    end
  end
end
