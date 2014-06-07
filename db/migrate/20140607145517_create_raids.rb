class CreateRaids < ActiveRecord::Migration
  def change
    create_table :raids do |t|
      t.references :city, index: true
      t.references :player, index: true
      t.integer :timber
      t.integer :bronze
      t.integer :food
      t.integer :capacity

      t.timestamps
    end
  end
end
