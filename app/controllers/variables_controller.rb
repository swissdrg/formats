class VariablesController < ApplicationController

  def show
    @variables =  Variable.where(:format_id => params[:format_id])
  end

  def new
    @variable = Variable.new
    @format_id = params[:format_id].to_i
  end

  def create
    puts "Create"
    full_params ||= variable_params
    full_params[:format_id] = format_params
    @variable = Variable.new(full_params)
    @variable.save
  end

  def update
    puts "Update"
    @variable = Variable.find(params[:id])

    full_params ||= variable_params
    full_params[:format_id] = format_params

    if @variable.update(full_params)
      redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end
  end

  def newform
    # vars = []
    # vars = vars << Variable.where(:format_id => params[:format_id]).to_a
    # render plain: vars
    # vars << Variable.new
    # @variables = vars
    @variables =  Variable.where(:format_id => params[:format_id])
    @variable = Variable.new

    @format_id = params[:format_id].to_i
  end

  private
  def variable_params
    # params.require(:format_id)
    params.require(:variable).permit(:number, :description, :length, :var_type)
  end

  def format_params
    params.require(:format_id)
  end
end