class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :game, required: true, foreign_key: { on_delete: :cascade }
      t.integer :position, required: true, default: 0
      t.timestamps null: false
    end
  end
end
