class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    
    def new
        @post = Post.new
    end
    
    def create
        @post = current_user.posts.build(post_params)
        @post.user = current_user
        if @post.save
            flash[:success] ="Post created"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def destroy
        @post = current_user.posts.find_by(id: params[:id])
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
