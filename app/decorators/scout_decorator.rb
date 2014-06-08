class ScoutDecorator < Draper::Decorator
  delegate_all

  def timber_number
    h.number_with_delimiter(timber)
  end

  def bronze_number
    h.number_with_delimiter(bronze)
  end

  def food_number
    h.number_with_delimiter(food)
  end

  def total_resources
    h.number_with_delimiter(timber + bronze + food)
  end
end
