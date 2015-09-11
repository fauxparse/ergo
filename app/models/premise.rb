class Premise < ActiveRecord::Base
  belongs_to :round, inverse_of: :premises
  has_many :played_cards, inverse_of: :premise, dependent: :destroy
end
