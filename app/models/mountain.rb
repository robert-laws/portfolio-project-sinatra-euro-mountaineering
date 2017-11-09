require_relative './concerns/slugifiable'

class Mountain < ActiveRecord::Base
  has_many :hiker_mountains
  has_many :hikers, through: :hiker_mountains
  has_many :clubs, through: :hikers

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end