class CreateLevelProgresses < ActiveRecord::Migration
  def change
    create_table :level_progresses do |t|
      t.decimal :level

      t.timestamps
    end
  end
end
