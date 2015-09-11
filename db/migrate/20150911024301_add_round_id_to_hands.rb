class AddRoundIdToHands < ActiveRecord::Migration
  def change
    change_table :hands do |t|
      t.belongs_to :round, required: true, index: true, foreign_key: { on_delete: :cascade }
    end
  end
end
