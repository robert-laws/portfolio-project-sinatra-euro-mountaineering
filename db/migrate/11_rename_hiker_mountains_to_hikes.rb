class RenameHikerMountainsToHikes < ActiveRecord::Migration[4.2]
  def change
    rename_table :hiker_mountains, :hikes
  end
end