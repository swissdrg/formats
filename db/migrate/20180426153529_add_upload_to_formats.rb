class AddUploadToFormats < ActiveRecord::Migration[5.1]
  def change
    add_column :formats, :attachment, :string
  end
end
