module Actions
  class Play < Action
    delegate :apply, to: :effect

    EFFECTS = {
      tabula_rasa:   "TabulaRasa",
      fallacy:       "Fallacy",
      justification: "Justification",
      ergo:          "Therefore"
    }

    private

    def effect
      effect_class.new(round, player, options)
    end

    def effect_class
      action = EFFECTS[options[:card_type]] ||
        options[:card_type].to_s.capitalize
      Actions.const_get(action)
    end
  end
end
