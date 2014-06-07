class AddRaidedAtToRaid < ActiveRecord::Migration
  def change
    add_column :raids, :raided_at, :datetime
  end
end
