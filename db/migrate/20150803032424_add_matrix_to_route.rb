class AddMatrixToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :matrix, :text
  end
end
