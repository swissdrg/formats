class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads, &:timestamps
  end
end
