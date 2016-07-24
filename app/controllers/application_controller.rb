class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  class Frbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
    
  rescue_from Exception, with: :rescue500
  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403
  rescue_from ActionController::RoutingError, with: :rescue404
  
  private 
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
  
  def rescue404(e)
    @exception = e
    render 'errors/not_found', status: 404
  end
  
  def rescue403(e)
    @exception = e
    render 'errors/forbidden', status: 403
  end
  
  def rescue500(e)
    @exception = e
    render 'errors/internal_server_error', status: 500
  end
  
end
