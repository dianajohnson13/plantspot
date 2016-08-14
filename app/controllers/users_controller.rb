class UsersController < ApplicationController
  
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

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  # PRIVATE
  private

    # user_params is for security; it limits potential data being passed from user in 'params' to be submitted
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
