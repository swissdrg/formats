class CreateVariables < ActiveRecord::Migration[5.1]
  def change
    create_table :variables do |t|
      t.string :number
      t.string :description
      t.int :length
      t.string :type
      t.references :format
      t.timestamps
    end
  end
end
