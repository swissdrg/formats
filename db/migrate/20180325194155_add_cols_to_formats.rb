class AddColsToFormats < ActiveRecord::Migration[5.1]
  def change
    add_column :formats, :name, :string
    add_column :formats, :attachment, :string
  end
end
