class FormatsController < ApplicationController
	# default order for actions is:
	# index, show, new, edit, create, update, destroy
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@formats = Format.all
	end

	def show
		@format = Format.find(params[:id])
	end

	def new
		@format = Format.new
		@format_id = @format.id.to_i
	end

	def edit
		@format = Format.find(params[:id])

    if File.readable?(@format.attachment.file.path)
      @json = File.read(@format.attachment.file.path)
    end
	end

	def create
		@format = Format.new(format_params)
    @format_id = @format.id.to_i

    if @format.save
			redirect_to '/formats'
		else
			render 'new'
    end
	end

	def update
		@format = Format.find(params[:id])
    @format_id = @format.id.to_i

    if File.writable?(@format.attachment.file.path)
      File.open(@format.attachment.file.path, 'w') do |f|
        f.write(params[:json])
      end
    end

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
		params.require(:format).permit(:title, :multiline, :attachment)
  end
end
