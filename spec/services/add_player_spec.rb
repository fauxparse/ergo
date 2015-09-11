require "rails_helper"

describe AddPlayer do
  subject { service.call }
  let(:game) { FactoryGirl.create(:game) }
  let(:service) { AddPlayer.new(game) }

  context "when the game is empty" do
    it "returns true" do
      expect(subject).to be true
    end

    it "creates a player" do
      expect { subject }.to change { Player.count }.by(1)
    end
  end

  context "when the game has two players" do
    before do
      2.times { AddPlayer.new(game).call }
    end

    it "returns true" do
      expect(subject).to be true
    end

    it "creates a player" do
      expect { subject }.to change { Player.count }.by(1)
    end

    it "gives the new player their proper position" do
      service.call
      expect(Player.last.position).to eq 2
    end
  end

  context "when the game is full" do
    before do
      Game::MAX_PLAYERS.times { AddPlayer.new(game).call }
    end

    it "returns false" do
      expect(subject).to be false
    end

    it "does not create a player" do
      expect { subject }.not_to change { Player.count }
    end
  end
end
