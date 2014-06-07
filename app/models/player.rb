class Player < ActiveRecord::Base
  has_many :cities
  has_many :raids
  has_many :scouts
end
