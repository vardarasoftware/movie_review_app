module Authenticatable
    extend ActiveSupport::Concern
  
    private
  
    def validate_email(email)
      if email.blank?
        flash.now[:alert] = "Email is required."
        return false
      end
  
      unless email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
        flash.now[:alert] = "Please enter a valid email address."
        return false
      end
  
      true
    end
  
    def validate_password(password)
      if password.blank?
        flash.now[:alert] = "Password is required."
        return false
      end
  
      true
    end
  
    def process_email(email)
      email&.strip&.downcase
    end
  
    def authenticate_user(user_class, email, password)
      user = user_class.find_by(email: email)
      
      if user&.authenticate(password)
        yield(user) if block_given?
        true
      else
        flash.now[:alert] = "Invalid email or password."
        false
      end
    end
  
    def handle_authentication_success(user, redirect_path, success_message = "Logged in successfully.")
      session[user_session_key] = user.id
      redirect_to redirect_path, notice: success_message
    end
  
    def handle_authentication_failure
      render :new
    end
  
    def logout_user
      session[user_session_key] = nil
    end
  
    # This method should be overridden in the including class
    def user_session_key
      raise NotImplementedError, "Subclasses must implement user_session_key method"
    end
  end