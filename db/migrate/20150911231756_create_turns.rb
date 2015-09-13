class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.belongs_to :round, index: true, required: true,
        foreign_key: { on_delete: :cascade }
      t.belongs_to :player, index: true, required: true,
        foreign_key: { on_delete: :cascade }
      t.integer :position, required: true
      t.timestamps null: false
    end
  end
end
