class AddUserIdToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.belongs_to :user, index: true, required: true,
        foreign_key: { on_delete: :cascade }
    end
  end
end
