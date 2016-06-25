class PostsController < ApplicationController
    befor_action :logged_in_user, only[:create]
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] ="Post created"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_page/home'
        end
    end
    
    def destroy
        @post = current_user.post.find_by(id: params[:id])
        return redirect_to root_url if @post.nil?
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_to request.referrer || root_url
    end
    
    private
    def post_params
        params.require(:post).permit(:content, :image)
    end
end