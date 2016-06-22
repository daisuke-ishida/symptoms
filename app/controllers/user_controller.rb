class UserController < ApplicationController
  def index
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
   else
     render 'new'
    end
  end
  
  private
    
    def user_params
      params.require(user).permit(:name, :age, :sex, :email, :password, :password_confirmation, :symptoms)
    end
    
end
