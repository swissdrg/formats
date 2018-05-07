# User Account Overview Page
class UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def show
    @user = current_user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  #def user_params
  #  params.fetch(:user, {})
  #end
end
