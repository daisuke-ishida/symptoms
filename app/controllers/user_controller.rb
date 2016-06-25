class UserController < ApplicationController
  def index
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcom to symptoms!"
    redirect_to @user
   else
     render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.post.order(created_at: :desc)
  end
  
  private
    
    def user_params
      params.require(user).permit(:name, :age, :sex, :email, :password, :password_confirmation, :symptoms)
    end
    
end
