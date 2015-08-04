class Route < ActiveRecord::Base
	serialize :distances
	serialize :coordinates
	serialize :locations


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
			location = line.split("; ")
			coords = location[1].split(", ")
			temp_coordinates[location[0]] = {lat: coords[0].to_f, long: coords[1].to_f}
			temp_locations << location[0]
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
		distances.each  do |k,v|
			v.each do |k,v|
				self.matrix << "#{v} "
			end
			self.matrix << "\n"
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
