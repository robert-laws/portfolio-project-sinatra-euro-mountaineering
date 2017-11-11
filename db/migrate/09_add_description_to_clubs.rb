class AddDescriptionToClubs < ActiveRecord::Migration[4.2]
  def change
    add_column :clubs, :description, :string
  end
end