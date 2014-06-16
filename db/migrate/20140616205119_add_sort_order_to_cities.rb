class AddSortOrderToCities < ActiveRecord::Migration
  def change
    add_column :cities, :sort_order, :integer, default: 0
  end
end
