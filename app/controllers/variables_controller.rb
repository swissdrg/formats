
class VariablesController < ApplicationController
  include VariablesHelper

  def show
    @variables =  Variable.where(:format_id => params[:format_id])
    @format_id = params[:format_id].to_i
  end

  def new
    @variable = Variable.new

    @format_id = params[:format_id].to_i
  end

  # form allows for simultaneous updating and editing multiple variables
  def form
    @variables =  Variable.where(:format_id => params[:format_id])
    @variable = Variable.new
    @upload = Upload.new
    @format_id = params[:format_id].to_i
  end

  def create
    full_params ||= variable_params
    full_params[:format_id] = format_params

    should_skip_save = helpers.variable_is_empty(variable_params)
    # should_skip_save = false if params[:force]

    unless should_skip_save then
      @variable = Variable.new(full_params)
      @variable.save

      if @variable.save(full_params)
        redirect_back(fallback_location: root_path)
      else
        render 'edit'
      end
    end
  end

  def update
    @variable = Variable.find(params[:id])

    full_params ||= variable_params
    full_params[:format_id] = format_params

    if @variable.update(full_params)
      redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end
  end

  def destroy
    @variable = Variable.find(params[:id])
    @variable.destroy

    redirect_back(fallback_location: root_path)
  end

  private
  def variable_params
    params.require(:variable).permit(:number, :description, :length, :var_type, :perform_empty_check)
  end

  def format_params
    params.require(:format_id)
  end
end