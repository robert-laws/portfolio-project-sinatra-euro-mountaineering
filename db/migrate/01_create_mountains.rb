class CreateMountains < ActiveRecord::Migration[4.2]
  def change
    create_table :mountains do |t|
      t.string :name
      t.string :country
      t.integer :height
    end
  end
end