class AddCardsRemainingToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :cards_remaining, :integer, required: true
  end
end
