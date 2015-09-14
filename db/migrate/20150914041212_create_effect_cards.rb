class CreateEffectCards < ActiveRecord::Migration
  def change
    create_table :effect_cards do |t|
      t.belongs_to :round, required: true, index: true,
        foreign_key: { on_delete: :cascade }
      t.belongs_to :player, required: true, index: true,
        foreign_key: { on_delete: :cascade }
      t.belongs_to :target, required: true, index: true
      t.integer :played_in_turn, required: true
      t.string :symbol, required: true
      t.integer :rotation, required: true, default: 0
    end

    add_foreign_key :effect_cards, :players, column: :target_id,
      on_delete: :cascade
  end
end
