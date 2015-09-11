module Logic
  class Solver
    class Absorption < Rule
      def apply_to_expression(expression)
        apply_absorption(expression) if [:and, :or].include?(expression.to_sym)
      end

      private

      def apply_absorption(expression)
        left, right = expression.children
        flipped = ([:and, :or] - [expression.to_sym]).first
        append(left) if absorbs?(right, left, flipped)
        append(right) if absorbs?(left, right, flipped)
      end

      def absorbs?(right, left, flipped)
        right.to_sym == flipped && right.children.include?(left)
      end
    end
  end
end
