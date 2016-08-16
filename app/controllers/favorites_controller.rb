class FavoritesController < ApplicationController
    
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
        @favorites = Favorite.where(user_id: current_user.id)
        
        
    end
    
    
    def destroy
        @favorite = Favorite.find_by(params[:content])
        if @favorite.destroy
            redirect_to favorite_path
        end
    end
    
    
end

