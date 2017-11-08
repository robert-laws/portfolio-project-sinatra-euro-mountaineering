class CreateHikerMountains < ActiveRecord::Migration[4.2]
  def change
    create_table :hiker_mountains do |t|
      t.integer :hiker_id
      t.integer :mountain_id
    end
  end
end