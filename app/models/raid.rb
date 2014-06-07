class Raid < ActiveRecord::Base
  belongs_to :city
  belongs_to :player

  def total_resources
    timber + bronze + food
  end

  def capacity_pct
    BigDecimal.new(total_resources)/BigDecimal.new(capacity) * 100.0
  end
end
