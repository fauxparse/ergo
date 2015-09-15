class ProposeMove
  attr_reader :turn, :move, :options

  def initialize(turn, action, options = {})
    @turn = turn
    @action = action
    @options = options.with_indifferent_access
    @card = turn.hand.cards[options[:index_in_hand]]
  end

  def call
    @move = @turn.moves.build(
      action: @action,
      card_type: @card.to_sym,
      options: @options
    )
    hand.cards_array[index_in_hand] = nil if index_in_hand.present?
  end

  private

  def hand
    turn.round.hands.detect { |hand| hand.player_id == turn.player_id }
  end

  def index_in_hand
    options[:index_in_hand]
  end
end
