class AddDescriptionToMountains < ActiveRecord::Migration[4.2]
  def change
    add_column :mountains, :description, :string
  end
end