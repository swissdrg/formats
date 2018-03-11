class FormatsController < ApplicationController
	# default order for actions is:
	# index, show, new, edit, create, update, destroy

	def index
		@formats = Format.all
	end

	def show
		@format = Format.find(params[:id])
	end

	def new
		@format = Format.new
	end

	def edit
		@format = Format.find(params[:id])
	end


	def create
		@format = Format.new(format_params)

		if @format.save
			redirect_to '/formats'
		else
			render 'new'
		end
	end

	def update
		@format = Format.find(params[:id])

		if @format.update(format_params)
			redirect_to '/formats'
		else
			render 'edit'
		end
	end

	private
	def format_params
		params.require(:format).permit(:title, :multiline, variables_attributes: [:number, :description, :length, :type])
	end
end
