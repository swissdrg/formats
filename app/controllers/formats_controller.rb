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
	end

	def create
		@format = Format.new(format_params)

		@format.save
		redirect_to @format
	end

	private
		def format_params
			params.require(:format).permit(:title, :multiline)
		end
end
