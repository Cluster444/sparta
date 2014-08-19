class RenameRaidedAtToReportedAtOnRaids < ActiveRecord::Migration
  def change
    rename_column :raids, :raided_at, :reported_at
  end
end
