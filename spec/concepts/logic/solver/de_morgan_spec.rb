require "rails_helper"

describe Logic::Solver::DeMorgan do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::DeMorgan])
  end

  context "~(A • B)" do
    let(:expressions) { ["~(A • B)"] }

    it { is_expected.to prove("~ A ∨ ~B") }
  end

  context "~(A ∨ B)" do
    let(:expressions) { ["~(A ∨ B)"] }

    it { is_expected.to disprove("A") }
    it { is_expected.to disprove("B") }
  end
end
