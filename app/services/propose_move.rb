class ProposeMove
  attr_reader :turn, :move, :options

  def initialize(turn, action, card, options = {})
    @turn = turn
    @action = action
    @card = card
    @options = options.with_indifferent_access
  end

  def call
    @move = @turn.moves.build(
      action: @action,
      card_type: @card,
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
