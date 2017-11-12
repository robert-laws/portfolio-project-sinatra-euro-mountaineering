class AddYearFoundedToClubs < ActiveRecord::Migration[4.2]
  def change
    add_column :clubs, :year_founded, :integer
  end
end