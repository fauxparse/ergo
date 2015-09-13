class Move < ActiveRecord::Base
  belongs_to :turn, inverse_of: :moves

  enum action: [:discard, :insert, :play]

  serialize :options, JSON
end
