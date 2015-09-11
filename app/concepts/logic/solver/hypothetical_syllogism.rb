module Logic
  class Solver
    class HypotheticalSyllogism < Rule
      def apply_to_expression(expression)
        apply_hypothetical_syllogism(expression) if expression.to_sym == :then
      end

      private

      def apply_hypothetical_syllogism(expression)
        solver.expressions.each do |other|
          shortcut(expression, other) if syllogism?(expression, other)
        end
      end

      def syllogism?(a, b)
        b.to_sym == :then && a.right.eql?(b.left)
      end

      def shortcut(a, b)
        append(Logic::Then.new(a.left, b.right))
      end
    end
  end
end
