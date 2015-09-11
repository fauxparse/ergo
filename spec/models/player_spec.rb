require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to validate_presence_of(:game_id) }
  it { is_expected.to validate_presence_of(:position) }
end
