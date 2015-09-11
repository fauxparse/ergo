class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :players_count, default: 0, required: true
      t.integer :rounds_count, default: 0, required: true
      t.timestamps null: false
    end
  end
end
