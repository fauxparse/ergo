require "rails_helper"

describe Deck do
  subject { deck }
  let(:deck) { Deck.new }

  describe "#size" do
    subject { deck.size }

    it { is_expected.to eq(55) }
  end
end
