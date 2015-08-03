class AddDistancesToRoutes < ActiveRecord::Migration
  def change 
  	change_table :routes do |t|
  		t.text	:distances
  		t.string :description
  end
end
end
