class CreatePlayedCards < ActiveRecord::Migration
  def change
    create_table :played_cards do |t|
      t.belongs_to :premise, required: true, index: true, foreign_key: { on_delete: :cascade }
      t.integer :position, required: true
      t.string :symbol, required: true
      t.integer :rotation, required: true, default: 0
      t.timestamps null: false
    end
  end
end
