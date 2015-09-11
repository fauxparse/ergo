module Logic
  class Solver
    class Idempotence < Rule
      def apply_to_expression(expression)
        apply_idempotence(expression) if [:and, :or].include?(expression.to_sym)
      end

      private

      def apply_idempotence(expression)
        append(expression.left) if expression.left.eql?(expression.right)
      end
    end
  end
end
