module Actions
  class Fallacy < Effect
    def apply
      round.effect_cards.build(
        player: options[:player],
        target: options[:target],
        symbol: :fallacy,
        played_in_turn: round.turns.count
      )
    end

    def beginning_of_turn(turn, card)
      card.rotation = turns_since_played(turn, card) % 4
      card.mark_for_destruction if card.rotation.zero?
    end

    private

    def turns_since_played(turn, card)
      round.turns.select do |t|
        t.position > card.played_in_turn && t.player == card.target
      end.length
    end
  end
end
