class AddStorageCapacityToCity < ActiveRecord::Migration
  def change
    add_column :cities, :timber_storage, :integer
    add_column :cities, :bronze_storage, :integer
    add_column :cities, :food_storage, :integer
  end
end
