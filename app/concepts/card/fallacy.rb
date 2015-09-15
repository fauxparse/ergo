class Card::Fallacy < Card
  def play(turn, player, options)
    turn.round.effect_cards.build(
      player: player,
      target_id: options[:target_id],
      symbol: to_sym,
      played_in_turn: turn.round.turns.count
    )
  end

  def beginning_of_turn(turn, effect)
    turns_since_played = turns_for_current_player(turn)

    effect.rotation = turns_since_played % 4
    effect.mark_for_destruction if turns_since_played >= 4
  end

  private

  def turns_for_current_player(current_turn)
    turns = (current_turn.round.turns.to_a + [current_turn]).uniq
    turns.count { |t| t.player_id == current_turn.player_id }
  end
end
