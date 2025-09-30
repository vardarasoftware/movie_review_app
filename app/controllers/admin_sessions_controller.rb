class AdminSessionsController < ApplicationController
  include Authenticatable

  def new
    flash.clear
  end

  def create
    email = process_email(params[:email])
    password = params[:password]

    # Validate email and password
    unless validate_email(email) && validate_password(password)
      handle_authentication_failure
      return
    end

    # Authenticate user
    if authenticate_user(AdminUser, email, password) do |admin|
        handle_authentication_success(admin, admin_root_path)
      end
    else
      handle_authentication_failure
    end
  end

  def destroy
    logout_user
    redirect_to admin_login_path, notice: "Logged out successfully."
  end

  private

  def user_session_key
    :admin_user_id
  end
end