# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= ((session[:user_id] && User.find(session[:user_id])) || 0)
  end

  def logged_in?
      current_user != 0
  end

  def check_authentication
    unless logged_in?
      flash[:notice] = "You need to login to do that"
      redirect_to :controller => 'users', :notice => "You need to log in to do that"
    end
  end

  def index
    redirect_to :controller => 'users'
  end
end
