class ConcatinateUploadAndFormat < ActiveRecord::Migration[5.1]
  def change
    add_reference :uploads, :format, index: true
  end
end
