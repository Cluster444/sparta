class City < ActiveRecord::Base
  belongs_to :player
  has_many :raids
  has_many :scouts
  has_many :level_progresses

  after_commit :track_level_progress

  def coordinates
    Coordinates.new(x,y)
  end

  def current_resources(kind)
    ResourceEstimator.new(self, kind).estimate
  end

  def estimated_raid_resources
    return nil unless acropolis

    t = current_resources(:timber)
    b = current_resources(:bronze)
    f = current_resources(:food)
    return nil unless t && b && f

    t = [0, t - acropolis].max
    b = [0, b - acropolis].max
    f = [0, f - acropolis].max
    t + b + f
  end

  def last_battle_report_at
    last_raid = raids.order(raided_at: :desc).first
    last_scout = scouts.order(scouted_at: :desc).first
    return nil unless last_raid || last_scout
    return last_scout.scouted_at unless last_raid
    return last_raid.raided_at unless last_scout
    [last_raid.raided_at, last_scout.scouted_at].max
  end

private

  def track_level_progress
    if level_progresses.empty? || level_progresses.last.level < level
      level_progresses.create!(level: level)
    end
  end
end
