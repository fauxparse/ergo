class AddStateToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :state, :integer, required: true, default: 0
  end
end
