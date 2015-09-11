module Logic
  class Solver
    class ModusTollens < Rule
      def apply_to_expression(expression)
        apply_modus_tollens(expression) if expression.to_sym == :then
      end

      private

      def apply_modus_tollens(expression)
        append(expression.left.negated) if solver.disproved?(expression.right)
      end
    end
  end
end
