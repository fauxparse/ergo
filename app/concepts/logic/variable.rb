module Logic
  class Variable < Expression
    value :name, String

    def to_s
      name
    end

    def eql?(other)
      other.is_a?(Variable) &&
      name == other.name
    end

    def variable?
      true
    end
  end
end
