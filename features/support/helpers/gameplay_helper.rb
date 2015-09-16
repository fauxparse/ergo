module FeatureSupport
  module GameplayHelper
    def player_number(number)
      @game.players.detect { |player| player.position == number.to_i - 1 }
    end

    def hand_for(player)
      @round.hands.detect { |hand| hand.player == player }
    end

    def card_named(name)
      name = name.to_s.tr(" ", "_")
      name.downcase! unless name.length == 1
      Card.from_symbol(name)
    end

    def index_in_hand(card, hand)
      hand.cards_array.index(card.to_sym.to_s)
    end

    def played_card_from_display_char(character, index)
      attrs = case character
              when Logic::AND then { symbol: :and }
              when Logic::OR then { symbol: :or }
              when Logic::NOT then { symbol: :not }
              when Logic::THEN then { symbol: :then }
              when ")" then { symbol: :"(", rotation: 2 }
              else { symbol: character.to_sym }
              end

      PlayedCard.new(attrs.merge(position: index))
    end

    def insert_card(player, card, options = {})
      propose_move(player, :play, card, options)
    end

    def discard(player, card, options = {})
      propose_move(player, :discard, card, options)
    end

    def play_card(player, card, options = {})
      propose_move(player, :play, card, options)
    end

    def propose_move(player, action, card, options)
      hand = hand_for(player_number(player))
      index = index_in_hand(card_named(card), hand)
      options[:index_in_hand] = index
      ProposeMove.new(@turn, action, options).call
    end
  end
end
