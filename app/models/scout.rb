class Scout < ActiveRecord::Base
  belongs_to :city

  validates :city,       presence: true
  validates :timber,     presence: true, numericality: {only_integer: true}
  validates :bronze,     presence: true, numericality: {only_integer: true}
  validates :food,       presence: true, numericality: {only_integer: true}
  validates :reported_at, presence: true

  after_create do
    city.update(last_battle_reported_at: reported_at)
  end
end
