class Raid < ActiveRecord::Base
  belongs_to :city

  validates :city,      presence: true
  validates :timber,    presence: true, numericality: {only_integer: true}
  validates :bronze,    presence: true, numericality: {only_integer: true}
  validates :food,      presence: true, numericality: {only_integer: true}
  validates :capacity,  presence: true, numericality: {only_integer: true}
  validates :reported_at, presence: true

  after_create do
    # FIXME Move this into RaidsController#create
    city.update(last_battle_reported_at: reported_at)
  end

  before_create :calculate_expires_at

  def self.last_week
    where('reported_at > ?', Time.now - 1.week)
  end
  
  def resources
    timber + bronze + food
  end

  def at_capacity?
    resources > (capacity * 0.95 - 1).round(0)
  end

  private

  def calculate_expires_at
    self.expires_at = reported_at.utc.midnight + 7.days
  end
end
