module Logic
  class Solver
    class SplitAnd < Rule
      def apply_to_expression(expression)
        append(*expression.children) if expression.to_sym == :and
      end
    end
  end
end
