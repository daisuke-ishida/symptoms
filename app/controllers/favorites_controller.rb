class FavoritesController < ApplicationController
    
    # post_id と user_idがパラメータで渡ってくる
    def create
        @favpost = Post.find(params[:post_id])
        @favorite = current_user.favorites.build(user_id: current_user.id, post_id: @favpost.id)
        if @favorite.save
          redirect_to user_path(@favpost.user.id)
        end
    end
    
    def show
        @user = current_user
        @favorites = Favorite.where(user_id: @user.id)
    end
    
    
    def destroy
        @favorite = Favorite.find(params[:id])
        if favorite.destroy
            redirect_to user_path
        end
    end
    
end
