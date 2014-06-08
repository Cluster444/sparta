class ScoutDecorator < Draper::Decorator
  delegate_all

  def timber_number
    number_with_delimiter(model.timber)
  end

  def bronze_number
    number_with_delimiter(model.bronze)
  end

  def food_number
    number_with_delimiter(model.food)
  end

  def total_resources
    number_with_delimiter(timber + bronze + food)
  end
end
