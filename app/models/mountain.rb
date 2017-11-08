require_relative './concerns/slugifiable'

class Mountain < ActiveRecord::Base
  has_many :hikers, through: :hiker_mountains

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end