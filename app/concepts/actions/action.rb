module Actions
  class Action
    attr_reader :round, :player, :options

    def initialize(round, player, options = {})
      @round = round
      @player = player
      @options = options.symbolize_keys
    end

    private

    def hand
      @hand ||= round.hands.detect { |hand| hand.player == player }
    end

    def remove_card_from_hand
      hand.cards_array[index_in_hand] = nil
    end

    def card
      hand.cards[index_in_hand]
    end

    def index_in_hand
      options[:index_in_hand]
    end
  end
end
