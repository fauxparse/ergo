class ChangeTurnNumberToTurnsCount < ActiveRecord::Migration
  def change
    rename_column :rounds, :turn_number, :turns_count
  end
end
