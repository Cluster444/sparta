class AddScoutedAtToRaid < ActiveRecord::Migration
  def change
    add_column :raids, :scouted_at, :datetime
  end
end
