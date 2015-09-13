class AddScoreToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.integer :score, required: true, default: 0
    end
  end
end
