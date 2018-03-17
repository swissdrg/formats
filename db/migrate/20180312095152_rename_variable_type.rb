class RenameVariableType < ActiveRecord::Migration[5.1]
  def change
    change_table :variables do |t|
      t.rename :type, :var_type
    end
  end
end
