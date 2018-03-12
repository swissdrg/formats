class VariablesController < ApplicationController

  def show
    @variables =  Variable.where(:format_id => params[:format_id])
    puts @variables
    puts @variables.inspect
  end

  def new
    @variable = Variable.new
    @format_id = params[:format_id].to_i
  end

  def create
    full_params ||= variable_params
    full_params[:format_id] = format_params
    @variable = Variable.new(full_params)
    @variable.save
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