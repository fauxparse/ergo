class Premise < ActiveRecord::Base
  belongs_to :round, inverse_of: :premises
  has_many :played_cards, inverse_of: :premise, dependent: :destroy,
    autosave: true

  after_initialize :set_position, unless: :position?

  validates :position, presence: { allow_blank: false }

  private

  def set_position
    self.position ||= round.premises.length
  end
end
