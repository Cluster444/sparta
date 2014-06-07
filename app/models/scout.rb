class Scout < ActiveRecord::Base
  belongs_to :city
  belongs_to :player

  def total_resources
    timber + bronze + food
  end
end
