class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :player, index: true
      t.string :name
      t.integer :x
      t.integer :y
      t.integer :acropolis

      t.timestamps
    end
  end
end
