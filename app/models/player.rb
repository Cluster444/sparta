class Player < ActiveRecord::Base
  belongs_to :user
  has_many :cities
  has_many :raids, through: 'cities'
  has_many :scouts, through: 'cities'

  validates :name, presence: true

  def coordinates
    Coordinates.new(x, y)
  end
end
