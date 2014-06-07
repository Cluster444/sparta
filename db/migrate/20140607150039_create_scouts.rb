class CreateScouts < ActiveRecord::Migration
  def change
    create_table :scouts do |t|
      t.references :player, index: true
      t.references :city, index: true
      t.integer :timber
      t.integer :bronze
      t.integer :food

      t.timestamps
    end
  end
end
