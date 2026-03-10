class SessionsController < ApplicationController
  # Google sends a POST request back, so we skip the authenticity token check for this action
  skip_before_action :verify_authenticity_token, only: :omniauth

  def omniauth
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    
    if user.persisted?
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed in!'
    else
      redirect_to root_path, alert: "Failed to sign in: #{user.errors.full_messages.join(', ')}"
    end
  end
end