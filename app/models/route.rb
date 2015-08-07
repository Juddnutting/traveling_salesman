class Route < ActiveRecord::Base
	serialize :distances
	serialize :coordinates
	serialize :locations
	serialize :solution
	serialize :optimal_path


	def build_all
		self.format_input
		self.calc_distances
		self.build_matrix
	end

	

	def format_input
		temp_coordinates = {}
		temp_locations = []
		ary = self.input.lines.map(&:chomp)
		ary.each do |line|
			coords = line.split(", ")
			temp_coordinates[coords[0]] = {lat: coords[1].to_f, long: coords[2].to_f}
			temp_locations << coords[0]
		end
		self.coordinates = temp_coordinates
		self.locations = temp_locations.sort
	end

	
	def calc_distances
		locations.each do |place|
			self.distances[place] = {}
			locations.each do |next_place|
				if place == next_place
					self.distances[place][next_place] = 0
				elsif next_place > place
					self.distances[place][next_place] = dist_on_earth(coordinates[place][:lat],
															coordinates[place][:long],
															coordinates[next_place][:lat],
															coordinates[next_place][:long])
				else
					self.distances[place][next_place] = distances[next_place][place]
				end
			end 
		end
	end

	def build_matrix
		self.matrix = ""
		distances.each  do |k,v|
			v.each do |k,v|
				matrix << "#{v} "
			end
			matrix << "\n"
		end
	end

	def TSP_header
		header = "NAME: #{self.description} input file
		Type: TSP
		COMMENT: #{self.description}
		DIMENSION: #{self.locations.size}
		EDGE_WEIGHT_TYPE: EXPLICIT
		EDGE_WEIGHT_FORMAT: FULL_MATRIX
		EDGE_WEIGHT_SECTION \n"

		header
	end

	def parse_solution
		self.solution = self.solution.strip.split(" ").map(&:to_i)
	end

	def build_optimal_path
		solution.each do |index|
			optimal_path << locations[index]
		end
	end

	

	private

		def dist_on_earth(lat1, long1, lat2, long2, radius=6378.388)
		deg_to_rad = Math::PI / 180.0

		phi1 = (90.0 - lat1) * deg_to_rad
		phi2 = (90.0 - lat2) * deg_to_rad

		theta1 = long1 * deg_to_rad
		theta2 = long2 * deg_to_rad

		cos = (Math::sin(phi1) * Math::sin(phi2)* Math::cos(theta1 - theta2) + 
				Math::cos(phi1) * Math::cos(phi2))
		arc = Math::acos(cos)
		(arc * radius / 1.60934).to_i # result in miles
		end



end
