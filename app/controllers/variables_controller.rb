class VariablesController < ApplicationController

  def show
    @variables =  Variable.where(:format_id => params[:format_id])
  end

  def new
    @variable = Variable.new
    @format_id = params[:format_id].to_i
  end

  # newform allows for simultaneous updating and editing multiple variables
  def newform
    @variables =  Variable.where(:format_id => params[:format_id])
    @variable = Variable.new

    @format_id = params[:format_id].to_i
  end

  def create
    puts "Create"
    full_params ||= variable_params
    full_params[:format_id] = format_params

    variable_is_empty = true

    [:number, :description, :length, :var_type].each do |key|
      unless full_params[key.to_sym].nil? then
        variable_is_empty &= (full_params[key.to_sym].to_s.length == 0)
      end
    end


    unless variable_is_empty then
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

  private
  def variable_params
    params.require(:variable).permit(:number, :description, :length, :var_type)
  end

  def format_params
    params.require(:format_id)
  end
end