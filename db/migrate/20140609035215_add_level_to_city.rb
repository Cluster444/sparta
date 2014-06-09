class AddLevelToCity < ActiveRecord::Migration
  def change
    add_column :cities, :level, :decimal, precision: 4, scale: 1
  end
end
