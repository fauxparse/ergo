require "rails_helper"

describe Logic::Solver::Involution do
  subject(:solver) { Logic::Solver.new(expressions) }

  before do
    allow_any_instance_of(Logic::Solver)
      .to receive(:rule_classes)
      .and_return([Logic::Solver::Involution])
  end

  context "~(~A)" do
    let(:expressions) { ["not (not A)"] }

    it { is_expected.to prove("A") }
  end
end
