class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :game
      t.integer :position, default: 0, required: true
      t.timestamps null: false
    end
  end
end
