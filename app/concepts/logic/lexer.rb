class Logic::Lexer < RLTK::Lexer
  rule(/\s+/)
  rule(/[A-Z]/) { :VAR }
  rule(/\(/)    { :LPAREN }
  rule(/\)/)    { :RPAREN }
  rule(/not/)   { :NOT }
  rule(/and/)   { :AND }
  rule(/or/)    { :OR }
  rule(/then/)  { :THEN }
end