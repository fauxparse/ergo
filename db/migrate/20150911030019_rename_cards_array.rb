class RenameCardsArray < ActiveRecord::Migration
  def change
    rename_column :hands, :cards, :cards_array
  end
end
