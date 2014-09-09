class AddTripwireToCity < ActiveRecord::Migration
  def change
    add_column :cities, :tripwire, :boolean, default: false
  end
end
