class DropTableVariables < ActiveRecord::Migration[5.1]
  def change
    drop_table :variables, if_exists: true
  end
end
