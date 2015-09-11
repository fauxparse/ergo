require "rails_helper"

describe CreateRound do
  subject { service.call }
  let(:service) { CreateRound.new(game) }
  let(:round) { service.round }
  let(:game) { FactoryGirl.create(:game, :with_players) }

  describe "#call" do
    before { subject }

    it "deals out cards" do
      remaining = round.deck.size - round.players.count * Hand::SIZE
      expect(round.cards_remaining).to eq(remaining)
    end

    it "puts the cards in the players’ hands" do
      round.hands.each do |hand|
        expect(hand.cards).to have_exactly(Hand::SIZE).items
        expect(hand.cards.all? { |c| c.is_a?(Card) }).to be true
      end
    end

    it "creates four empty premises" do
      expect(round.premises.count).to eq 4
    end
  end
end
