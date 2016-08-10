class StaticPagesController < ApplicationController
  def home
    @posts = []
    if logged_in?
      @micropost = current_user.microposts.build
      @posts = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about

  end
end
