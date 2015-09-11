require "rails_helper"

describe Logic::Solver::Idempotence do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::Idempotence])
  end

  context "A • A" do
    let(:expressions) { ["A and A"] }

    it { is_expected.to prove("A") }
  end

  context "A ∨ A" do
    let(:expressions) { ["A or A"] }

    it { is_expected.to prove("A") }
  end
end
