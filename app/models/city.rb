class City < ActiveRecord::Base
  belongs_to :player
  has_many :raids
  has_many :scouts
  has_many :level_progresses

  after_commit :track_level_progress

  def self.active
    last_report_within 7.days
  end

  def self.last_report_within(time)
    includes(:scouts, :raids).references(:scouts, :raids)
      .where('raids.reported_at > :time OR scouts.reported_at > :time', time: time.ago).uniq
  end

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
    last_raid = raids.order(reported_at: :desc).first
    last_scout = scouts.order(reported_at: :desc).first
    return nil unless last_raid || last_scout
    return last_scout.reported_at unless last_raid
    return last_raid.reported_at unless last_scout
    [last_raid.reported_at, last_scout.reported_at].max
  end

private

  def track_level_progress
    if level_progresses.empty? || level_progresses.last.level < level
      level_progresses.create!(level: level)
    end
  end
end
