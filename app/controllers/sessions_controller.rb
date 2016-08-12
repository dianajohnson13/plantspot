class SessionsController < ApplicationController
  # inherits inclusion of SessionsHelper through ApplicationController
  
  def new
    @user = User.new
  end

  def create
    userInput = session_params
    user = User.find_by(email: userInput[:email])
    if user && user.authenticate(userInput[:password])
      login(user)
      # if the user checks off the remember me box on login, use advanced 'remember-token' auth
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else 
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end

  # PRIVATE
  private

    # user_params is for security; it limits potential data being passed from user in 'params' to be submitted
    def session_params
      params.require(:session).permit(:email, :password, :user_id, :remember_me)
    end

end
