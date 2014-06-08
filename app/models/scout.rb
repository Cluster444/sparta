class Scout < ActiveRecord::Base
  belongs_to :city
  belongs_to :player

  validates :city,     presence: true
  validates :player,   presence: true
  validates :timber,   presence: true, numericality: {only_integer: true}
  validates :bronze,   presence: true, numericality: {only_integer: true}
  validates :food,     presence: true, numericality: {only_integer: true}

  def total_resources
    timber + bronze + food
  end
end
