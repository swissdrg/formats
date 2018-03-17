class CreateVariables < ActiveRecord::Migration[5.1]
  def change
    create_table :variables do |t|
      t.string :number
      t.string :description
      t.integer :length
      t.string :type
      t.references :format
      t.timestamps
    end
  end
end
