module Logic
  class Solver
    class Involution < Rule
      def apply_to_expression(expression)
        apply_involution(expression) if expression.to_sym == :not
      end

      private

      def apply_involution(expression)
        append(expression.operand.operand) if expression.operand.to_sym == :not
      end
    end
  end
end
