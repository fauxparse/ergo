RSpec::Matchers.define :prove do |expression|
  match do |solver|
    expression = solver.parse(expression) if expression.is_a?(String)
    solver.solve!
    solver.proved?(expression)
  end

  failure_message do |solver|
    "expected #{solver} to prove #{expression}; \
     proofs were #{solver.expressions.map(&:to_s).join(', ')}"
  end
end

RSpec::Matchers.define :disprove do |expression|
  match do |solver|
    expression = solver.parse(expression) if expression.is_a?(String)
    solver.solve!
    solver.disproved?(expression)
  end

  failure_message do |solver|
    "expected #{solver} to disprove #{expression}; \
     proofs were #{solver.expressions.map(&:to_s).join(', ')}"
  end
end
