class UsersController < ApplicationController
  before_filter :set_access_control_headers

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = ENV['CLIENT_URL']
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, PATCH, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Origin, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
    headers['Access-Control-Max-Age'] = '1000'
  end

  def options
    head :ok
  end

  def show
    id = session[:user_id]

    return redirect_to '/auth/twitter' if id.nil?

    @user = User.find( id )

  end

end
