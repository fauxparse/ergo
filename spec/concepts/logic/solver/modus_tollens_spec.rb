require "rails_helper"

describe Logic::Solver::ModusTollens do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::ModusTollens])
  end

  context "A ⊃ B, ~B" do
    let(:expressions) { ["A ⊃ B", "~B"] }

    it { is_expected.to disprove("A") }
  end
end
