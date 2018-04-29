class RemoveMultilineColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :formats, :multiline
  end
end
