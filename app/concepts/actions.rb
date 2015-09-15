module Actions
  def self.from_move(turn, player, move)
    const_get(move.action.to_s.capitalize)
      .new(turn, player, move.options.merge(card_type: move.card_type.to_sym))
  end
end
