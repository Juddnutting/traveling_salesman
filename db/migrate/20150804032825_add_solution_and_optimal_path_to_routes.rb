class AddSolutionAndOptimalPathToRoutes < ActiveRecord::Migration
  def change
  	add_column :routes, :solution, :text
  	add_column :routes, :optimal_path, :text
  end
end
