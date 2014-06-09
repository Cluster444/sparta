class AddCoordinatesToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :x, :integer
    add_column :players, :y, :integer
  end
end
