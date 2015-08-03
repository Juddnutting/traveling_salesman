class AddInputToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :input, :string
  end
end
