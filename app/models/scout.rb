class Scout < ActiveRecord::Base
  belongs_to :city
  belongs_to :player
end
