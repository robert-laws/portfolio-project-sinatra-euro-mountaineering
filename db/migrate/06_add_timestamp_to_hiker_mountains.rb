class AddTimestampToHikerMountains < ActiveRecord::Migration[4.2]
  def change
    change_table(:hiker_mountains) { |t| t.timestamps }
  end
end