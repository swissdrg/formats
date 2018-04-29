# Handles CRUD Operations and Upload for Format specifications
class FormatsController < ApplicationController
  # default order for actions is:
  # index, show, new, edit, create, update, destroy
  before_action :authenticate_user!, except: %i[index show]

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
    @json = read_attachment(@format)
    @json = '{}' if @json.empty?
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
    
    if update_attachment(@format, params[:json]) && @format.update(format_params)
      redirect_to '/formats'
    else
      redirect_back(fallback_location: '/formats', flash: { alert: 'Could not save changes' })

    end
  end

  def destroy
    @format = Format.find(params[:id])
    @format.destroy

    redirect_to '/formats'
  end

  private

  def read_attachment(format)
    return if !format.attachment.file.present? || !File.readable?(format.attachment.file.path)
    File.read(format.attachment.file.path)
  end

  def update_attachment(format, json)
    return if !format.attachment.file.present? || !File.writable?(@format.attachment.file.path)

    File.open(format.attachment.file.path, 'w') do |f|
      f.write(json)
      true
    end
  end

  def format_params
    params.require(:format).permit(:title, :attachment)
  end
end
