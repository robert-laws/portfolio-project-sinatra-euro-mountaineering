require_relative './concerns/slugifiable'

class Mountain < ActiveRecord::Base
  has_many :hikes
  has_many :hikers, through: :hikes
  has_many :clubs, through: :hikers

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end