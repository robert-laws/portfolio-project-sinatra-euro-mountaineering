class AddCommentsToHikerMountains < ActiveRecord::Migration[4.2]
  def change
    add_column :hiker_mountains, :comments, :string
  end
end