require "rails_helper"

describe Logic::Solver::ModusPonens do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::ModusPonens])
  end

  context "A ⊃ B, A" do
    let(:expressions) { ["A then B", "A"] }

    it { is_expected.to prove("B") }
  end
end
