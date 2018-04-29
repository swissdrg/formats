class RemoveFaultyCols < ActiveRecord::Migration[5.1]
  def change
    remove_column :formats, :name
    remove_column :formats, :attachment
  end
end
