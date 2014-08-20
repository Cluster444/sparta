class Player < ActiveRecord::Base
  has_many :cities
  has_many :raids, through: 'cities'
  has_many :scouts, through: 'cities'

  def coordinates
    Coordinates.new(x, y)
  end
end
