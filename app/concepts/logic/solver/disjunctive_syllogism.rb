module Logic
  class Solver
    class DisjunctiveSyllogism < Rule
      def apply_to_expression(expression)
        apply_disjunctive_syllogism(expression) if expression.to_sym == :or
      end

      private

      def apply_disjunctive_syllogism(expression)
        append(expression.right) if solver.disproved?(expression.left)
        append(expression.left) if solver.disproved?(expression.right)
      end
    end
  end
end
