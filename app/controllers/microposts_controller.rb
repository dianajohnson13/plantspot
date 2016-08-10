class MicropostsController < ApplicationController
  before_action :confirm_user_logged_in, only: [:create, :destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url
    else
      @posts = current_user.feed
      render 'static_pages/home'
    end
  end

  def destroy
    # will need to id post by id...
  end

  private 
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
