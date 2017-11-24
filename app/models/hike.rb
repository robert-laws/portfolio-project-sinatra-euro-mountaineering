class Hike < ActiveRecord::Base
  belongs_to :hiker
  belongs_to :mountain
end