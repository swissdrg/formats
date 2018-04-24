class ChangePasswordsController < ApplicationController
  before_action :require_login

  #def edit
   # if user = find_user_for_create
    #  user.forgot_password!
   #end
    # render template: 'change_passwords/edit', :params => {:password_reset_token => user.}
  #end

  def edit
    generate_ghost_token
    @user = current_user


    #if params[:token]
     # session[:password_reset_token] = params[:token]
      #redirect_to url_for(user_id: params[:user_id])
    #else
     # render template: 'change_passwords/edit'
    #end
  end


  def update
    @user = current_user


    if @user.update(password_change_params)

      @user.update_password(:password_reset)

      redirect_to '/formats'
    else
      logger.info "was för en kack"
      render 'change_passwords/edit'
    end
  end


  def password_change_params
    if params.has_key? :user
      ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
      params[:user][:password]
    else
      params[:password_reset][:password]
    end
  end


  def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = session[:password_reset_token] || params[:token]

    Clearance.configuration.user_model.
        find_by_id_and_confirmation_token params[user_param], token.to_s
  end


  def generate_ghost_token

    @user = current_user
    @user.forgot_password!

  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end


end
