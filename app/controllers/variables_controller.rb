class VariablesController < ApplicationController

  def show
    @variables =  Variable.where(:format_id => params[:format_id])
    puts @variables
    puts @variables.inspect
  end

  def new
    @variable = Variable.new
    @format_id = params[:format_id]
  end

  def create
    @variable = Variable.new(variable_params)
    @variable.save
  end

  private
  def variable_params
    params.require(:format_id)
    params.permit(:number, :description, :length)
  end
end