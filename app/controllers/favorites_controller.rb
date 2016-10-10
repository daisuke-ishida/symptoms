class FavoritesController < ApplicationController
    
    before_action :correct_user, only: [:show]
    before_action :check_timeout
    
    # post_id と user_idがパラメータで渡ってくる
    def create
        @favpost = Post.find(params[:post_id])
        @favorite = current_user.favorites.build(user_id: current_user.id, post_id: @favpost.id, content: @favpost.content,
                     image: @favpost.image)
        if @favorite.save
        #  redirect_to user_path(@favpost.user.id)
           redirect_to favorite_path(current_user.id)
        end
    end
    
    def show
        @favorites = Kaminari.paginate_array(Favorite.where(user_id: current_user.id).order(created_at: :desc)).page(params[:page]).per(10)
    end

    def destroy
        @favorite = Favorite.find(params[:id])
        if @favorite.destroy
            redirect_to favorite_path(current_user.id)
        end
    end
    
    private
    
    def correct_user
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to root_url
    end
  end
    
     TIMEOUT = 2.minutes
  
   def check_timeout
    if current_user
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(user_id: current_user.id)
        flash[:alert] = "セッションがタイムアウトしました。"
        redirect_to new_session_path
      end
    end
   end
    
end
