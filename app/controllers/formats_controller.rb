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

		# @variables =  Variable.where(:format_id => params[:format_id])
		# @variable = Variable.new

		@format_id = @format.id.to_i

	end

	def edit
		@format = Format.find(params[:id])
	end

	def create
		@format = Format.new(format_params)
    @format_id = @format.id.to_i

		if @format.save
			redirect_to :controller => 'variables', :action => 'form', :format_id => @format.id.to_i
		else
			render 'new'
    end
	end

	def update
		@format = Format.find(params[:id])
    @format_id = @format.id.to_i

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
		params.require(:format).permit(:title, :multiline, variables_attributes: [:number, :description, :length, :type], uploads_attirbutes: [:attachment])
	end
end
