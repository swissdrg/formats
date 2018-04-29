# User Account Overview Page
class UsersController < ApplicationController
  def show
    @user = current_user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {})
  end
end
