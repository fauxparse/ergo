require "rails_helper"

describe Logic::Solver::HypotheticalSyllogism do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::HypotheticalSyllogism])
  end

  context "A ⊃ B, B ⊃ C" do
    let(:expressions) { ["A ⊃ B", "B ⊃ C"] }

    it { is_expected.to prove("A ⊃ C") }
  end
end
