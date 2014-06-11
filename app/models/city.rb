class City < ActiveRecord::Base
  belongs_to :player
  has_many :raids
  has_many :scouts
  has_many :level_progresses

  after_commit :track_level_progress

  def coordinates
    Coordinates.new(x,y)
  end

  def current_bronze
    nil
  end

  def current_timber
    nil
  end

  def current_food
    nil
  end

private

  def track_level_progress
    if level_progresses.empty? || level_progresses.last.level < level
      level_progresses.create!(level: level)
    end
  end
end
