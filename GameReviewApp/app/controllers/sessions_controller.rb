class SessionsController < ApplicationController
  skip_before_action :login_required

  def new 
    #Already logged in redirect to Home
    redirect_to user_path(current_user) if current_user
    
    @loginSession = Session.new
  end

  def create
    #LoginUserSearch
    @loginSession = Session.new(session_params)
    user = User.find_by(email: session_params[:email]) 
    #Login Validate and Authenticate
    if @loginSession.save && user&.authenticate(session_params[:password])
      log_in user
      remember user
      redirect_to user_path(user.id), notice: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path, noice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
