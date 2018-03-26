class FormatsController < ApplicationController
	# default order for actions is:
	# index, show, new, edit, create, update, destroy
	before_action :require_login, except: [:index, :show]

	def index
		@formats = Format.all
	end

	def show
		@format = Format.find(params[:id])
	end

	def new
		@format = Format.new

		@variables =  Variable.where(:format_id => params[:format_id])
		@variable = Variable.new

		@format_id = @format.id.to_i
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

	def destroy
		@format = Format.find(params[:id])
		@format.destroy

		redirect_to '/formats'
	end

	private
	def format_params
		params.require(:format).permit(:title, :multiline, :name, :attachment, variables_attributes: [:number, :description, :length, :type])
	end
end
