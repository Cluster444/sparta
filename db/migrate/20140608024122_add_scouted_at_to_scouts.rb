class AddScoutedAtToScouts < ActiveRecord::Migration
  def change
    add_column :scouts, :scouted_at, :datetime
  end
end
