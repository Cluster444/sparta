class RenameScoutedAtToReportedAtOnScouts < ActiveRecord::Migration
  def change
    rename_column :scouts, :scouted_at, :reported_at
  end
end
