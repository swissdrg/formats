class VariablesController < ApplicationController

  def show
    @variable = Variable.find(params[:id])
  end

end
