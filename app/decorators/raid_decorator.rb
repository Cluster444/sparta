class RaidDecorator < Draper::Decorator
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

  def capacity_pct
    pct = BigDecimal.new(timber + bronze + food)/BigDecimal.new(capacity) * 100.0
    h.number_to_percentage(pct, precision: 0)
  end

  def report_datetime
    reported_at.strftime('%m/%d/%Y %H:%M')
  end
end
