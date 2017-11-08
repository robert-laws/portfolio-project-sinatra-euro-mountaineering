class Hiker < ActiveRecord::Base
  belongs_to :club
  has_many :mountains, through: :hiker_mountains
end