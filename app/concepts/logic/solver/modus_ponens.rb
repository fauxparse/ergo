module Logic
  class Solver
    class ModusPonens < Rule
      def apply_to_expression(expression)
        apply_modus_ponens(expression) if expression.to_sym == :then
      end

      private

      def apply_modus_ponens(expression)
        append(expression.right) if solver.proved?(expression.left)
      end
    end
  end
end
