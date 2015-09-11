require "rails_helper"

describe CreateGame do
  subject { service.call }
  let(:service) { CreateGame.new }

  it "creates a game" do
    expect { subject }.to change { Game.count }.by(1)
  end
end
