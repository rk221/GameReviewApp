class SessionsController < ApplicationController
  def new
    @loginSession = Session.new
  end

  def create
    @loginSession = Session.new(session_params)
    user = User.find_by(email: session_params[:email]) 

    if @loginSession.save && user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to users_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
