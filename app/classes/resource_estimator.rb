class ResourceEstimator
  def initialize(city, resource)
    @city, @resource = city, resource
  end

  def estimate
    last_scout = @city.scouts.first
    last_raid  = @city.raids.first

    resources = 
      if last_scout && (!last_raid || (last_scout.reported_at > last_raid.reported_at))
        last_scout.send(@resource) + production_since(last_scout.reported_at)
      elsif last_raid && @city.acropolis && !last_raid.at_capacity?
        @city.acropolis + production_since(last_raid.reported_at)
      elsif last_raid && last_scout && last_raid.at_capacity?
        amount_left = last_scout.send(@resource) - (last_raid.send(@resource) * (1/0.95)).round(0)
        amount_left + production_since(last_scout.reported_at)
      else
        nil
      end

    resources && [resources, (@city.send("#{@resource}_storage") || 999999)].min
  end

  def production_since(time)
    production = @city.send("#{@resource}_production")

    if %w(timber bronze).include? @resource && production.nil?
      production = 100
    end

    if production.nil?
      0
    else
      (production * (Time.now - time) / 3600).to_i
    end
  end
end
