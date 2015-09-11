module Logic
  class Solver
    class Rule
      attr_accessor :solver

      def initialize(solver)
        @solver = solver
      end

      def apply
        @solver.expressions.inject(false) do |changed, expression|
          apply_to_expression(expression) || changed
        end
      end

      def apply_to_expression(_)
        false
      end

      def append(*expressions)
        expressions.each do |expression|
          @solver.expressions << expression unless @solver.proved?(expression)
        end
      end
    end
  end
end
