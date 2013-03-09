class SessionsController < ApplicationController

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to ENV['CLIENT_URL']
  end

  def destroy
    session[:user_id] = nil
    redirect_to ENV['CLIENT_URL']
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def handle_unverified_request
    true
  end

end
