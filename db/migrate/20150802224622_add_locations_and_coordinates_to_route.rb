class AddLocationsAndCoordinatesToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :locations, :text
    add_column :routes, :coordinates, :text
  end
end
