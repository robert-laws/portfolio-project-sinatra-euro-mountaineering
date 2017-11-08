class Mountain < ActiveRecord::Base
  has_many :hikers, through: :hiker_mountains
end