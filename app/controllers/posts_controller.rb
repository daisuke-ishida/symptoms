class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :followed]
    before_action :correct_user, only: [:create, :destroy, :followed]
    before_action :check_timeout
    
    
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
    
    def followed

        ids = Favorite.joins(:post).where(posts: {user_id: current_user.id}).group(:post_id).order('count_post_id desc').limit(50).count(:post_id).keys

        @fav_posts = Post.find(ids).sort_by do |o|
            ids.index(o.id)
        end
        
        @faved_posts = Kaminari.paginate_array(@fav_posts).page(params[:page]).per(10)
        
        
    end
        
    
    private
    def post_params
        params.require(:post).permit(:content, :image)
    end
    
    def correct_user
        @user = User.find(params[:id])
        if @user !=current_user
          redirect_to root_url
        end
    end
      
      TIMEOUT = 60.minutes
  
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
