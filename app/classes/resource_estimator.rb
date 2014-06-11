class ResourceEstimator
  def initialize(city, resource)
    @city, @resource = city, resource
  end

  def estimate
    last_scout = @city.scouts.last
    last_raid  = @city.raids.last

    resources = 
      if last_scout && (!last_raid || (last_scout.scouted_at > last_raid.raided_at))
        last_scout.send(@resource) + production_since(last_scout.scouted_at)
      elsif last_raid && @city.acropolis && !last_raid.at_capacity?
        @city.acropolis + production_since(last_raid.raided_at)
      elsif last_raid && last_scout && last_raid.at_capacity?
        amount_left = last_scout.send(@resource) - (last_raid.send(@resource) * (1/0.95)).round(0)
        amount_left + production_since(last_scout.scouted_at)
      else
        nil
      end

    resources && [resources, (@city.send("#{@resource}_storage") || 999999)].min
  end

  def production_since(time)
    production = @city.send("#{@resource}_production")
    
    if production.nil?
      0
    else
      (production * (Time.now - time) / 3600).to_i
    end
  end
end
