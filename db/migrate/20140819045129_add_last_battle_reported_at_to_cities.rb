class AddLastBattleReportedAtToCities < ActiveRecord::Migration
  def change
    add_column :cities, :last_battle_reported_at, :datetime
  end
end
