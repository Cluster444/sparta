class RemovePlayerFromRaid < ActiveRecord::Migration
  def change
    remove_column :raids, :player_id
  end
end
