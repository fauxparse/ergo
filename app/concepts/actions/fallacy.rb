module Actions
  class Fallacy < Effect
    def apply
      round.effect_cards.build(
        player_id: options[:player_id],
        target_id: options[:target_id],
        symbol: :fallacy,
        played_in_turn: round.turns.count
      )
    end

    def beginning_of_turn(_, card)
      card.rotation = turns_since_played(card) % 4
      card.mark_for_destruction if card.rotation.zero?
    end

    private

    def turns_since_played(card)
      round.turns.to_a.count do |t|
        t.position > card.played_in_turn && t.player == card.target
      end
    end
  end
end
