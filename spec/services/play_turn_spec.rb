require "rails_helper"

describe PlayTurn do
  subject { service.call }
  let(:service) { PlayTurn.new(round, turn) }
  let(:round) { CreateRound.new(game).tap(&:call).round }
  let(:game) { FactoryGirl.create(:game, :with_players) }
  let(:turn) { BeginTurn.new(round).tap(&:call).turn }
  let(:hand) { turn.hand }

  def discard_first_card_in_hand
    index = hand.cards.find_index(&:present?)
    ProposeMove.new(turn, :discard, index_in_hand: index).call
  end

  def expect_error(message)
    service.call
    expect(service.errors.full_messages).to include(message)
  end

  def next_cards_drawn_are(*cards)
    allow_any_instance_of(DrawCards)
      .to receive(:cards)
      .and_return(cards.map { |c| Card.from_symbol(c) })
  end

  def play_card_to_proof(card, options)
    index = turn.hand.cards.find_index { |c| c.try(:to_sym) == card.to_sym }
    ProposeMove.new(turn, :play, options.merge(index_in_hand: index)).call
  end

  context "when the player draws two random cards" do
    before do
      DrawCards.new(turn.hand).call
    end

    context "but does not play or discard them" do
      it { is_expected.to be false }

      it "has an error" do
        expect_error("Player 1 has too many cards in their hand")
      end
    end

    context "and discards one" do
      before do
        discard_first_card_in_hand
      end

      it { is_expected.to be false }

      it "has an error" do
        expect_error("A turn consists of exactly two moves")
      end
    end

    context "and discards two" do
      before do
        2.times { discard_first_card_in_hand }
      end

      it { is_expected.to be true }

      it "has no errors" do
        service.call
        expect(service.errors).to be_empty
      end
    end

    context "and discards three" do
      before do
        3.times { discard_first_card_in_hand }
      end

      it { is_expected.to be false }

      it "has an error" do
        expect_error("A turn consists of exactly two moves")
      end
    end
  end

  context "when the player draws an A and a B" do
    before do
      round
      next_cards_drawn_are(:A, :B)
      DrawCards.new(turn.hand).call
    end

    it "has an A and a B in hand" do
      expect(hand.cards_array).to include("A")
      expect(hand.cards_array).to include("B")
    end

    it "has 7 cards in hand" do
      expect(hand.cards_array.size).to be 7
    end

    context "and plays them legally" do
      before do
        play_card_to_proof(:A, premise: 0, position: 0)
        play_card_to_proof(:B, premise: 1, position: 0)
      end

      it { is_expected.to be true }
    end

    context "and plays them illegally" do
      before do
        play_card_to_proof(:A, premise: 0, position: 0)
        play_card_to_proof(:B, premise: 0, position: 1)
      end

      it { is_expected.to be false }

      it "has an error" do
        expect_error("Premise 1 is incorrectly formed")
      end
    end
  end
end
