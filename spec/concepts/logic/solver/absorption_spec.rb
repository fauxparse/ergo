require "rails_helper"

describe Logic::Solver::Absorption do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::Absorption])
  end

  context "A ∨ (A • B)" do
    let(:expressions) { ["A ∨ (A • B)"] }

    it { is_expected.to prove("A") }
  end

  context "A • (A ∨ B)" do
    let(:expressions) { ["A • (A ∨ B)"] }

    it { is_expected.to prove("A") }
  end
end
