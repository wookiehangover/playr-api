class ApplicationController < ActionController::Base

  def index
    redirect_to ENV['CLIENT_URL']
  end

end
