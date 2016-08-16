class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  # PRIVATE
  private

    # user_params is for security; it limits potential data being passed from user in 'params' to be submitted
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    # confirms logged-in user
    def logged_in_user
      unless logged_in?
        redirect_to login_url
      end
    end

    # used above in 'before action', allowing a logged in user to edit/udate ONLY their account
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
