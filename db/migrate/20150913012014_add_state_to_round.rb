class AddStateToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :state, :integer, required: true, default: 0
  end
end
