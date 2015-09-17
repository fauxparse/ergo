class FixPlayerReadyState < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.boolean :ready, required: true, default: false
    end

    remove_column :players, :state
  end
end
