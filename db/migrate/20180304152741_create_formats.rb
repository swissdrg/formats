class CreateFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :formats do |t|
      t.string :title
      t.boolean :multiline

      t.timestamps
    end
  end
end
