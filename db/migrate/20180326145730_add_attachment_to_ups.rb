class AddAttachmentToUps < ActiveRecord::Migration[5.1]
  def change
    add_column :uploads, :name, :string
    add_column :uploads, :attachment, :string
  end
end
