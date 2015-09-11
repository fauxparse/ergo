class Logic::Parser < RLTK::Parser
  left :AND
  left :OR
  left :THEN

  production(:expression) do
    clause("subexpression") { |e| e }
    clause("NOT subexpression") { |_, e| [:not, e] }
    clause("expression AND expression") { |e1, _, e2| [e1, :and, e2] }
    clause("expression OR expression") { |e1, _, e2| [e1, :or, e2] }
    clause("expression THEN expression") { |e1, _, e2| [e1, :then, e2] }
  end

  production(:subexpression) do
    clause("VAR") { |e| e.inspect }
    clause("LPAREN expression RPAREN") { |_, e, _| e }
  end

  finalize
end