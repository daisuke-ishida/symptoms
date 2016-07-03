class FavoritesController < ApplicationController
    def create
        @user_id = session[:id]
        @post_id = Post.find(params[:id]).id
        @favorite = Favorite.new(post_id: @post_id, user_id: @user_id)
        if favorite.save
          redirect_to pot_path
        end
    end
    
    def destroy
        @favorite = Favorite.find(params[:id])
        if favorite.destroy
            redirect_to user_path
        end
    end
end
