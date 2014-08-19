class Raid < ActiveRecord::Base
  belongs_to :city
  belongs_to :player

  validates :city,      presence: true
  validates :player,    presence: true
  validates :timber,    presence: true, numericality: {only_integer: true}
  validates :bronze,    presence: true, numericality: {only_integer: true}
  validates :food,      presence: true, numericality: {only_integer: true}
  validates :capacity,  presence: true, numericality: {only_integer: true}
  validates :reported_at, presence: true

  def self.last_week
    where('reported_at > ?', Time.now - 1.week)
  end
  
  def resources
    timber + bronze + food
  end

  def at_capacity?
    resources > (capacity * 0.95 - 1).round(0)
  end
end
