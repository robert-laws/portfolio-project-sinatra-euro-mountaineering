class CreateHikers < ActiveRecord::Migration[4.2]
  def change
    create_table :hikers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :club_id
      t.string :username
      t.string :password_digest
    end
  end
end