class DropTableUploads < ActiveRecord::Migration[5.1]
  def change
    drop_table :uploads, if_exists: true
  end
end
