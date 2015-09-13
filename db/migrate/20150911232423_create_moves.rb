class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.belongs_to :turn, index: true, required: true,
        foreign_key: { on_delete: :cascade }
      t.integer :action, required: true
      t.string :card_type, required: true
      t.text :options, required: true, default: "{}"
    end
  end
end
