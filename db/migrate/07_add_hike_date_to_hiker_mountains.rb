class AddHikeDateToHikerMountains < ActiveRecord::Migration[4.2]
  def change
    add_column :hiker_mountains, :hike_date, :datetime
  end
end