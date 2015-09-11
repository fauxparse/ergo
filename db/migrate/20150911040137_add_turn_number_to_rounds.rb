class AddTurnNumberToRounds < ActiveRecord::Migration
  def change
    change_table :rounds do |t|
      t.integer :turn_number, required: :true, default: 0
    end
  end
end
