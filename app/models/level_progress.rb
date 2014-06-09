class LevelProgress < ActiveRecord::Base
  belongs_to :city

  validates :level, presence: true
end
