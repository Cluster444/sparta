class RemoveScoutedAtFromRaids < ActiveRecord::Migration
  def change
    remove_column :raids, :scouted_at
  end
end
