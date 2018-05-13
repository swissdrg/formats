# Handles CRUD Operations and Upload for Format specifications
class FormatsController < ApplicationController
  # default order for actions is:
  # index, show, new, edit, create, update, destroy

  # noinspection RailsParamDefResolve
  before_action :authenticate_user!, except: %i[index show]

  def index
    @formats = Format.all
  end

  def show
    @format = Format.find(params[:id])
    @json = []
    # TODO: Handle error if ['vars'] not found
    begin
      JSON.parse(helpers.read_attachment(@format))['vars'].each { |k, v|
        @json << { 'Name' => k, 'Position' => v['position'], 'Type' => v['type'], 'Missings' => v['missings'], 'Truthy Values' => v['true_values']}
      }
    rescue
    end
  end

  def new
    @format = Format.new
    @format_id = @format.id.to_i
  end

  def edit
    @format = Format.find(params[:id])
    @json = helpers.read_attachment(@format)
    @json = '{}' unless @json.present?
  end

  def create
    @format = Format.new(format_params)
    if @format.save
      redirect_to '/formats'
    else
      render action: :new
    end
  end

  def update
    format = Format.find(params[:id])
    @format = format
    @json = helpers.read_attachment(@format)
    if update_format(format, params[:json])
      redirect_to '/formats'
    else
      render action: :edit
    end
  end

  def destroy
    @format = Format.find(params[:id])
    @format.destroy

    redirect_to '/formats'
  end

  private

  def update_format(format, json)
    helpers.update_attachment(format, json) && format.update(format_params)
  end

  def format_params
    params.require(:format).permit(:title, :attachment)
  end
end
