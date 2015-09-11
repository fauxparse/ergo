require "rails_helper"

describe Logic::Solver::DisjunctiveSyllogism do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::DisjunctiveSyllogism])
  end

  context "A ∨ B, ~A" do
    let(:expressions) { ["A or B", "not A"] }

    it { is_expected.to prove("B") }
  end
end
