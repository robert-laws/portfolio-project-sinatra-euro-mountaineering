class Club < ActiveRecord::Base
  has_many :hikers

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end