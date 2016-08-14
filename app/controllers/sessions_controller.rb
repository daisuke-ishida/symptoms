class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "loged in as #{@user.name}"
      render 'show'
    else
      flash[:danger] = "invalid email/password combination"
      render 'new'
    end
  end
  
  def show
    @user = current_user
    if logged_in?
      render 'show'
    else
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
end
