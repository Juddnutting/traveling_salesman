require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  
	def setup
		@route = routes(:test1)
		@route.format_input
		@formatted_route  = @route
		@route = routes(:test1)
	end

	test "should format input into coordinates hash and locations array" do
		assert_kind_of(String, @route.input)
		@route.format_input
		assert_kind_of(Array, @route.locations)
		assert_kind_of(Hash, @route.coordinates)
	end

	test "should have locations sorted" do
		assert_equal(@formatted_route.locations, @formatted_route.locations.sort)
	end

	test "should format input into correct lat long and location" do
		coord = @formatted_route.input.split("\n").first.split(", ")
		assert_equal(@formatted_route.coordinates[coord[0]], {lat: coord[1].to_f, long: coord[2].to_f} )
	end

	test "should have a coordinate for every location" do
		@formatted_route.coordinates do |k,v|
			assert @formatted_route.locations.include?(k)
		end 
	end


end
