require "rltk/ast"

module Logic
  class Expression < RLTK::ASTNode
    def to_s
      ""
    end

    def to_sym
      self.class.name.demodulize.underscore.to_sym
    end

    def negated
      Not.new(self)
    end

    def variable?
      false
    end
  end
end
