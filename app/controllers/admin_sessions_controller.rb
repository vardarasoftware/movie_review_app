class AdminSessionsController < ApplicationController
  def new
    # Debug: Clear any existing flash messages
    flash.clear
  end

  def create

    email = params[:email]&.strip&.downcase
    password = params[:password]

    #validate email
    if email.blank?
      flash.now[:alert] = "Email is required."
      render :new
      return
    end

    unless email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      flash.now[:alert] = "Please enter a valid email address."
      render :new and return
    end

    #validate password
    if password.blank?
      flash.now[:alert] = "Password is required."
      render :new
      return
    end

    # Use the processed email variable, not params[:email]
    admin = AdminUser.find_by(email: email)

    if admin&.authenticate(password) 
      session[:admin_user_id] = admin.id
      redirect_to admin_root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_login_path, notice: "Logged out successfully."
  end
end