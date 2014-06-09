class AddCityToLevelProgress < ActiveRecord::Migration
  def change
    add_reference :level_progresses, :city, index: true
  end
end
