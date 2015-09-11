class Logic::Lexer < RLTK::Lexer
  rule(/[A-Z]/) { |name| [:VAR, name] }
  rule(/\(/)    { :LPAREN }
  rule(/\)/)    { :RPAREN }
  rule(/not/)   { :NOT }
  rule(/and/)   { :AND }
  rule(/or/)    { :OR }
  rule(/then/)  { :THEN }
  rule(/\s+/)
end
