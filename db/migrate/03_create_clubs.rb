class CreateClubs < ActiveRecord::Migration[4.2]
  def change
    create_table :clubs do |t|
      t.string :name
    end
  end
end