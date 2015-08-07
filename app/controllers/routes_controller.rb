class RoutesController < ApplicationController

	def new
		@route = Route.new
		
	end

	def create
		@route = Route.new(input: params[:route][:input], description: params[:route][:description],
							coordinates: {}, locations: [], distances: {}, matrix: "", solution: "", optimal_path: [])
		@route.build_all
		if @route.save
			flash[:success] = "Route successfully created"
			redirect_to output_path(@route)
		else
			redirect_to :new
		end
	end
	def index
		@all_routes = Route.all
	end

	def show
		@route = Route.find(params[:id])
	end

	def output
		@route = Route.find(params[:id])
	end

	def upload
		@route = Route.find(params[:id])
	end

	def create_solution
		@route = Route.find(params[:id])
		@route.solution = params[:route][:solution]
		if @route.save
			redirect_to root_url	
		end
	end

	private

		def output_path(resource)
			"/routes/#{resource.id}/output"
		end

end
