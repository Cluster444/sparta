class AddProductionRatesToCity < ActiveRecord::Migration
  def change
    add_column :cities, :timber_production, :integer
    add_column :cities, :bronze_production, :integer
    add_column :cities, :food_production, :integer
  end
end
