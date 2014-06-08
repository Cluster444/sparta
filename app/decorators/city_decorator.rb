class CityDecorator < Draper::Decorator
  delegate_all
  decorates_association :raids
  decorates_association :scouts

  def resource_cap
    resources = object.raids.last_week.reduce(0) do |sum,raid|
      sum + raid.timber + raid.bronze + raid.food
    end
    50000 - resources
  end

  def total_raided_resources
    object.raids.reduce(0) do |sum,raid|
      sum + raid.timber + raid.bronze + raid.food
    end
  end

  def location
    "#{x}, #{y}"
  end
end
