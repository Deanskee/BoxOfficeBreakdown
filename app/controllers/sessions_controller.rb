class SessionsController < ApplicationController
  def new
  end
  def create
  	if env["omniauth.auth"]
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    session_create
    redirect_to root_url
  	else
   	@user = User.where(email: params[:session][:email]).first

    if @user && @user.authenticate(params[:session][:password])
      session_create
      redirect_to root_url, notice: "You have successfully logged in."
    else
      flash.now[:notice] = "Invalid login/password combination. Please try again."
      render :new
    end
  end
 end
  def destroy
    session[:user_id] = nil
   
  
  session.delete(:remember_token)
  	redirect_to root_url
  end
end