class UserController < ApplicationController

  def index
    redirect_to :action => 'login'
  end

  def login
    @title = "Login"
  end

  def authenticate
    @user = User.new(params[:user])

    # TODO: Sort out hashing of password
    valid_user = User.find(:first, :conditions => ["username = ? and password = ?", @user.username, @user.password])
    if valid_user
      session[:user] = valid_user
      redirect_to :controller => 'expense'
    else
      flash[:notice] = "Invalid User/Password"
      redirect_to :login
    end
  end

  def logout
    if logged_in?
      reset_session
      redirect_to :login
    end
  end
  
end
