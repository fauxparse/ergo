class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.belongs_to :player, required: true, foreign_key: { on_delete: :cascade }
      t.string :cards, array: true, required: true, default: []
    end
  end
end
