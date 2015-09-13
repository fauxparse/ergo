module Actions
  class Therefore < Action
    def apply
      round.state = :finished
    end
  end
end
