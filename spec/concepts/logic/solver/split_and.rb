require "rails_helper"

describe Logic::Solver::SplitAnd do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::SplitAnd])
  end

  context "A • B" do
    let(:expressions) { ["A and B"] }

    it { is_expected.to prove("A") }
    it { is_expected.to prove("B") }
  end
end
