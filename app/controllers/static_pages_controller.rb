class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
  #    render 'sessions/show'
    else
      render 'static_pages/home'
    end
  end
end

 