require_relative './concerns/slugifiable'

class Hiker < ActiveRecord::Base
  belongs_to :club
  has_many :hiker_mountains
  has_many :mountains, through: :hiker_mountains

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
end