class City < ActiveRecord::Base
  belongs_to :player
  has_many :raids
  has_many :scouts
end
