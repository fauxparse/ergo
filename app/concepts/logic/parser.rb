module Logic
  class Parser < RLTK::Parser
    left :AND
    left :OR
    left :THEN
    right :NOT

    production(:expression) do
      clause("subexpression")              { |expr| expr }
      clause("NOT subexpression")          { |_, expr| Not.new(expr) }
      clause("expression AND expression")  { |lft, _, rgt| And.new(lft, rgt) }
      clause("expression OR expression")   { |lft, _, rgt| Or.new(lft, rgt) }
      clause("expression THEN expression") { |lft, _, rgt| Then.new(lft, rgt) }
    end

    production(:subexpression) do
      clause("variable") { |expr| expr }
      clause("LPAREN expression RPAREN") { |_, expr, _| expr }
    end

    production(:variable) do
      clause("VAR") { |name| Variable.new(name) }
    end

    finalize
  end
end
