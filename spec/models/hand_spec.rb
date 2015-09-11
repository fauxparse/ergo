require 'rails_helper'

RSpec.describe Hand, type: :model do
  it { is_expected.to validate_presence_of(:player_id) }
  it { is_expected.to validate_presence_of(:round_id) }
end
