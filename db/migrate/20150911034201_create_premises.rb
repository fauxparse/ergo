class CreatePremises < ActiveRecord::Migration
  def change
    create_table :premises do |t|
      t.belongs_to :round, required: true, index: true, foreign_key: { on_delete: :cascade }
      t.integer :position, required: true
    end
  end
end
