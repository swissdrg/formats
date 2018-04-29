class RemoveUserCols < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    create_table :users
  end

  # def self.up
  #  remove_column :users, :email
  # remove_column :users, :encrypted_password
  # remove_column :users, :remember_token
  # end

  # def down
  #  add_column :users, :email, :String
  #  add_column :users, :encrypted_password, :String
  #  add_column :users, :remember_token, :String
  # end
end
