class RemovePlayerFromScout < ActiveRecord::Migration
  def change
    remove_column :scouts, :player_id
  end
end
