class RoutesController < ApplicationController

	def new
		@route = Route.new
		
	end

	def create
		@route = Route.new(input: params[:route][:input], description: params[:route][:description],
							coordinates: {}, locations: [], distances: {}, matrix: "")
		# @route.build_all
		if @route.save
			redirect_to root_url
		end
	end
	def index
		@all_routes = Route.all
	end

	def output
		@route = Route.find(params[:id])
	end
end
