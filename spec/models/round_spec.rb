require 'rails_helper'

RSpec.describe Round, type: :model do
  subject { FactoryGirl.create(:round) }

  it { is_expected.to validate_presence_of(:game_id) }
  it { is_expected.to validate_presence_of(:cards_remaining) }

  it "initializes a deck" do
    expect(subject.cards_remaining).to eq(Deck.new.size)
  end
end
