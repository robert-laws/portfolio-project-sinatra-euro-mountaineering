require_relative './concerns/slugifiable'

class Hiker < ActiveRecord::Base
  belongs_to :club
  has_many :hikes
  has_many :mountains, through: :hikes

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
end