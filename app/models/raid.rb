class Raid < ActiveRecord::Base
  include BattleReport

  belongs_to :city
  belongs_to :player

  validates :city,      presence: true
  validates :player,    presence: true
  validates :timber,    presence: true, numericality: {only_integer: true}
  validates :bronze,    presence: true, numericality: {only_integer: true}
  validates :food,      presence: true, numericality: {only_integer: true}
  validates :capacity,  presence: true, numericality: {only_integer: true}
  validates :raided_at, presence: true

  def self.last_week
    where('raided_at > ?', Time.now - 1.week)
  end
end
